class AnswersSheetsController < ApplicationController
  before_action :signed_in_user
  PENDING = 0
  SUCCESS = 1
  TIMEOUT = 1800

  def index    
    @new_sheet = AnswersSheet.new 
    @answers_sheets = AnswersSheet.paginate(page: params[:page], 
      per_page: 5, order: "created_at DESC")
  end

  def show
    @answers_sheet = AnswersSheet.find params[:id]
  end

  def new
    subject_id = params[:answers_sheet][:subject_id]
    @answers_sheet = AnswersSheet.find_or_create_by(user_id: current_user.id, 
      subject_id: subject_id, status: PENDING)

    if (@answers_sheet.answers_sheet_details.length == 0)
       @question_ids = Question.find_by_subject(subject_id).ids
       @questions = Question.find(@question_ids.shuffle.take(30))
       @questions.each do |q|
         detail = @answers_sheet.answers_sheet_details
           .build(question_id: q.id)

         detail.question.answers.each do |answer|
           detail.user_answers.build(answer_id: answer.id)
         end
       end
       @answers_sheet.save
       time_passed = 0
    else
      now = Time.now.to_i
      time_passed = now - @answers_sheet.created_at.to_i
    end
    @countdown = TIMEOUT - time_passed
  end

  def update
    @answers_sheet = AnswersSheet.find params[:id]
    @answers_sheet.status = SUCCESS
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
        user_answers_attributes: [:id, :answer_id]])
  end
end
