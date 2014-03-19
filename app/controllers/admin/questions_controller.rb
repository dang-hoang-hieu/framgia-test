class Admin::QuestionsController < Admin::AdminsController  
  before_action :signed_in_admin
  
  def index
    cond = Hash.new    
    cond[:subject_id] = params[:subject_id] if params[:subject_id].to_i > 0
    cond[:level_id]   = params[:level_id]   if params[:level_id].to_i > 0
    @questions = Question.paginate(page: params[:page], 
      per_page: 5, order: "created_at DESC", conditions: cond)
  end

  def show
    @question = Question.find params[:id]
  end

  def new
    @question = Question.new
    3.times { @question.answers.build }
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "create question successfully"
      redirect_to [:admin, @question]
    else
      flash.now[:error] = "error in create question"
      render "new"
    end
  end
  
  def edit
    @question = Question.find params[:id]
  end
  
  def update
    @question = Question.find params[:id]
    if @question.update_attributes question_params
      flash[:success] = "update question successfully"
      redirect_to [:admin, @question]
    else
      flash.now[:error] = "error in create question"
      render "edit"
    end
  end

  def destroy
    @question = Question.find(params[:id]).destroy
    flash[:success] = "question Deleted!"
    redirect_to admin_questions_url
  end

  private
  def question_params
    params.require(:question).permit(:question, :level_id, :question_id, 
      :subject_id, answers_attributes: [:correct_answer, :answer, :id])
  end
end
