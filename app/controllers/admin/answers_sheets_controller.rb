class Admin::AnswersSheetsController < Admin::AdminsController  
  before_action :signed_in_admin  
  SUCCESS  = 1
  ASSERTED = 2
  
  def index
    @answers_sheets = AnswersSheet.paginate(page: params[:page], 
      per_page: 5, order: "created_at DESC")
  end

  def show
    @answers_sheet = AnswersSheet.find params[:id]
  end  

  def edit
    @answers_sheet = AnswersSheet.find params[:id]
    fill_user_answers_to @answers_sheet
  end

  def update
    @answers_sheet = AnswersSheet.find params[:id]
    @answers_sheet.status  = ASSERTED
    if @answers_sheet.update_attributes answers_sheet_params
      flash[:success] = "result asserted!"
      redirect_to [:admin, @answers_sheet]
    else
      flash.now[:error] = "error in assert"
      render "edit"
    end
  end
  
  private
  def answers_sheet_params
    params.require(:answers_sheet).permit(answers_sheet_details_attributes: [:id, 
     :correct, user_answers_attributes: [:id, :answer_id]])
  end

  private
  def fill_user_answers_to sheet
    sheet.answers_sheet_details.each do |detail|
      answers      = detail.question.answers.ids
      user_answers = detail.user_answers.pluck :answer_id
      unchecked_answers = answers - user_answers
      unchecked_answers.each do |ans_id|
        detail.user_answers.build(answer_id: ans_id)
      end

      correct_answers = detail.question.answers
        .where(:correct_answer).ids

      if correct_answers.equal? user_answers
        detail.correct = true
      end
    end
  end
end
