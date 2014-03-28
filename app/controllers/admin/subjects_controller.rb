class Admin::SubjectsController < Admin::AdminsController  
  before_action :signed_in_admin

  def index
    @subjects = Subject.paginate page: params[:page], per_page: 3,
      order: "created_at DESC"
  end

  def show
    @subject = Subject.find params[:id]
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "create subject successfully"
      redirect_to [:admin, @subject]
    else
      flash.now[:error] = "error in create subject"
      render "new"
    end
  end
  
  def edit
    @subject = Subject.find params[:id]
  end
  
  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash[:success] = "update subject successfully"
      redirect_to [:admin, @subject]
    else
      flash.now[:error] = "error in create subject"
      render "edit"
    end
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:success] = "Subject Deleted!"
    redirect_to admin_subjects_url
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :total_questions, :time_limit)
  end
end
