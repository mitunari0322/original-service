class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    question = Question.find(params[:question_id])
    current_user.like(question)
    flash["success"] = "お気に入りにしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    question = Question.find(params[:question_id])
    current_user.unlike(question)
    flash["danger"] = "お気に入りを解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
