require 'open-uri'
require 'securerandom'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

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
      redirect_to edit_user_path(@user)
    else
      flash[:info] = 'The user did not get created, please try again.'
      redirect_to :back
    end
  end

  def edit
  end

  def update
  end

  def show
    if params[:search]
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
