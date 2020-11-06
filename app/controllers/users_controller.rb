class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :likes, :followings, :followers]
  

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash["success"] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now["danger"] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  def likes
    @user = User.find(params["id"])
    @likes = @user.favorite_questions.page(params["page"])
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
