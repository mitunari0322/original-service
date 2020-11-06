class QuestionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    @questions = Question.order(id: :desc).page(params[:page]).per(25)
    @subjects = Subject.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    
    if @question.save
      flash[:success] = "質問を投稿しました。"
      redirect_to @question
    else
      @questions = current_user.questions.order(id: :desc).page(params[:page]).per(25)
      flash.now[:danger] = "質問の投稿に失敗しました。"
      render 'questions/index'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answers.build
    @answers = @question.answers.order(id: :desc).page(params[:page]).per(25)
  end

  def destroy
    @question.destroy
    flash[:success] = "質問を削除しました。"
    redirect_to root_url
  end
  
  private

  def question_params
    params.require(:question).permit(:title, :content, :subject_id)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
