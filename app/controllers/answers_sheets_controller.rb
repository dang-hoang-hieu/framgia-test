class AnswersSheetsController < ApplicationController
  before_action :signed_in_user
  PENDING = 0

  def index    
    @new_sheet = AnswersSheet.new 
    @answers_sheets = AnswersSheet.paginate(page: params[:page], 
      per_page: 5, order: "created_at DESC")
  end

  def show
    @answers_sheet = AnswersSheet.find params[:id]
  end

  def new
    subject_id = params[:subject_id]    
    exam_id = params[:exam_id]
    if subject_id.to_i > 0
      exam = Exam.find exam_id
      detail = exam.exams_subjects.find_by subject_id: subject_id
      @answers_sheet = generate_exam_by_subject(subject_id, detail.total_questions)
      redirect_to edit_answers_sheet_url @answers_sheet
    end
  end
  
  def edit
    @answers_sheet = AnswersSheet.find params[:id]
    now = Time.now.to_i
    time_passed = now - @answers_sheet.created_at.to_i
    time_limit = ExamsSubject.find_by(exam_id: @answers_sheet.exam_id,
      subject_id: @answers_sheet.subject_id).time_limit
    @countdown = time_limit - time_passed
    redirect_to answers_sheets_url if @countdown < 0
  end

  def update
    @answers_sheet = AnswersSheet.find params[:id]
    if @answers_sheet.update_attributes answers_sheet_params
      flash[:success] = "result submitted, wait for assertion"
      redirect_to @answers_sheet
    else
      flash.now[:error] = "error in submit"
      render "new"
    end
  end
  
  private
  def answers_sheet_params
    params.require(:answers_sheet).permit(:subject_id,
      answers_sheet_details_attributes: [ :id, 
        user_answers_attributes: [:id, :checked]])
    params.permit(:subject_id, :exam_id)
  end

  private
  def generate_exam_by_subject(subject_id, number_question = 30)
    answers_sheet = AnswersSheet.create(user_id: current_user.id, 
      subject_id: subject_id, status: PENDING, exam_id: params[:exam_id])

    question_ids = Question.find_by_subject(subject_id).ids
    questions = Question.find(question_ids.shuffle.take(number_question))
    questions.each do |q|
      detail = answers_sheet.answers_sheet_details.build(question_id: q.id)
      detail.question.answers.each do |answer|
        detail.user_answers.build(answer_id: answer.id)
      end
    end
    answers_sheet if answers_sheet.save
  end
end
