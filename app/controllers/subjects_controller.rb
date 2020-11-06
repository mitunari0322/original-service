class SubjectsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @subject = Subject.find(params[:id])
    @subjects = Subject.order(id: :desc).page(params[:page]).per(25)
    @questions = Question.where(subject_id: params[:id]).page(params[:page]).per(25)
  end
end
