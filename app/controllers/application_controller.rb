class ApplicationController < ActionController::Base
    
  include SessionsHelper  
    
  private
  
  def counts(user)
    @count_likes = user.favorites.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
