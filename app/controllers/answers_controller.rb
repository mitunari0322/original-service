class AnswersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    
    @answer.user = current_user
    if @answer.save
      flash[:success] = "回答を投稿しました。"
      redirect_to @question
    else
      flash.now[:danger] = "回答の投稿に失敗しました。"
      render 'new'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "回答を削除しました。"
    redirect_to root_url
  end
  
  private

    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
    
    def correct_user
    @answer = current_user.answers.find_by(id: params[:id])
    unless @answer
      redirect_to root_url
    end
  end
end

