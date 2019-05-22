class LinksController < ApplicationController

  def forward
    if params[:slug].length == 6
      Rails.logger.info("#{params[:slug]}")
      @user = User.where('slug = (?)', params[:slug]).first
      Rails.logger.info("In the if in forward, should have a @shortlink instance now")
    else
      Rails.logger.info("In the 1st else in forward, the shortened part was not exactly 6 chars long")
      flash[:error] =  'Short link entered is not correct. Please try again'
      return render "users/index"
    end

    if @user
        Rails.logger.info("it worked and now it should open the original url in a new page")
        redirect_to @user.website
    else
      Rails.logger.info("In the 2nd else in forward, there was no @shortlink instance found")
      flash[:error] = 'Short link not found. Please try again'
      return render "users/index"
    end
  end
end
