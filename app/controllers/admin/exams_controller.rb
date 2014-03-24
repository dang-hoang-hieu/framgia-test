class Admin::ExamsController < Admin::AdminsController
  before_action :signed_in_admin
  
  def index
    @exams = Exam.paginate(page: params[:page], 
      per_page: 5, order: "created_at DESC")
  end

  def new
    @exam = Exam.new    
    if params[:subject_number].to_i > 0
      params[:subject_number].to_i.times { @exam.exams_subjects.build }
      render "_exam_form", layout: false
    else
      params[:subject_number] = 1
      params[:subject_number].times { @exam.exams_subjects.build }
    end
  end

  def show
    @exam = Exam.find params[:id]
  end  
  
  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = "create exam successfully"
      redirect_to [:admin, @exam]
    else
      flash.now[:error] = "error in create exam"
      render "new"
    end
  end

  def edit
    @exam = Exam.find params[:id]
  end

  def update
    remove_unused_relations
    @exam = Exam.find params[:id]
    if @exam.update_attributes exam_params
      flash[:success] = "exam updated!"
      redirect_to [:admin, @exam]
    else
      flash.now[:error] = "error in update"
      render "edit"
    end
  end
  
  def destroy
    Exam.find(params[:id]).destroy
    flash[:success] = "delete successfully"
    redirect_to admin_exams_path    
  end

  private
  def exam_params
    params.require(:exam).permit(:name, exams_subjects_attributes: [:id, 
     :subject_id, :total_questions, :time_limit])
  end

  private
  def remove_unused_relations
    @exam = Exam.find params[:id]
    all_records = @exam.exams_subjects.pluck :id
    update_records = exam_params[:exams_subjects_attributes].map do |es|
      es[1]["id"].to_i
    end
    @exam.exams_subjects.find_by_ids(all_records - update_records).destroy_all
  end
end
