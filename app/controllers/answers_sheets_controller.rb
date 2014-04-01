class AnswersSheetsController < ApplicationController
  before_action :signed_in_user
  PENDING = 0
  SUCCESS = 1

  def create
    examination = Examination.find params[:examination_id]
    @answers_sheet = generate_answers_sheet_by examination
    redirect_to edit_examination_answers_sheet_url examination, @answers_sheet
  end
  
  def edit
    @answers_sheet = AnswersSheet.find params[:id]
    @examination = @answers_sheet.examination

    @countdown = time_left_of_answers_sheet @answers_sheet
    if @countdown < 0
      redirect_to examinations_url     
    end
  end

  def update
    @answers_sheet = AnswersSheet.find params[:id]
    @answers_sheet.status = SUCCESS
    if @answers_sheet.update_attributes answers_sheet_params
      flash[:success] = "result submitted, wait for assertion"
      redirect_to examinations_url      
    else
      flash.now[:error] = "error in submit"
      render "edit"
    end
  end
  
  private
  def answers_sheet_params
    params.require(:answers_sheet).permit(:id,
      answers_sheet_details_attributes: [ :id, 
        user_answers_attributes: [:id, :checked]])
  end

  private
  def generate_answers_sheet_by examination
    answers_sheet = AnswersSheet.create(subject_id: examination.subject_id || params[:subject_id], 
      status: PENDING, examination_id: examination.id)
    
    answers_sheet.generate_questions
    answers_sheet if answers_sheet.save
  end

  private
  def time_left_of_answers_sheet answers_sheet
    now = Time.now.to_i
    time_passed = now - answers_sheet.created_at.to_i
    exams_subject = ExamsSubject.find_by(exam_id: answers_sheet.examination.exam_id,
      subject_id: answers_sheet.subject_id)
    time_limit = exams_subject.try(:time_limit) || 30 * 60
    time_limit - time_passed
  end
end
