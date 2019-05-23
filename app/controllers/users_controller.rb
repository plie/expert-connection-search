require 'open-uri'
require 'securerandom'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    doc = Nokogiri::HTML(open("#{@user.website}"))

    # create arrays to hold only the text portions of heading elements
    doc.search('h1').each { |h| @user.head_one << h.text }
    doc.search('h2').each { |h| @user.head_two << h.text }
    doc.search('h3').each { |h| @user.head_three << h.text }

    @user.slug = SecureRandom.alphanumeric(6)

    if @user.save!
      flash[:info] = 'New user created'
      redirect_to user_path(@user)
    else
      flash[:info] = 'The user did not get created, please try again.'
      redirect_to :back
    end

    # alternative implemention: utilize the headings table
    # headings_one = doc.search('h1').map { |h| h.text }
    # headings_two = doc.search('h2').map { |h| h.text }
    # headings_three = doc.search('h3').map { |h| h.text }
    # headings = headings_one | headings_two | headings_three
    # headings = headings.map { |h| h.downcase }

    # not working correctly yet, need to add ead heading to different rows
    # currently this adds only one row, with incorrect data structure for topics column
    # @user.headings.create(topics: headings)
  end

  def edit
    @not_yet_friends = User.where.not(id: @user.self_and_friend_ids)
  end

  def update
    friend = params[:friended_user_id]
    if Friend.create!(user_id: @user.id, friended_user_id: friend)
      flash[:info] = 'You successfully added a new mutual friend'
      redirect_to edit_user_path(@user)
    end
  end

  def show
    @friends = User.where(id: @user.friend_ids)

    if params[:search]
      prospects = User.where(id: @user.prospect_ids)
      headings = []
      @matched_prospects_array = []

      # prospects.each do |p|  # attempt to pull the data from the matched results into an array - not used
      #   headings = (p.head_one | p.head_two | p.head_three).map { |h| h.downcase }
      #   headings.each do |h|
      #     @matched_prospects_array << {p.id => h} if h.include?("#{params[:search]}")
      #   end
      # end

      @matched_prospects = prospects.select do |p|   # holding actual members that are prospects
        headings = p.head_one | p.head_two | p.head_three
        headings = headings.map { |h| h.downcase }
        expert_match_headings = headings.select do |h|
          h.include?("#{params[:search]}")
        end
        expert_match_headings.any?
      end

    end

  end

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :website, :slug, :heading, :search)
  end
end
