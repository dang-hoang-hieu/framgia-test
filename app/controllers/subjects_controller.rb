class SubjectsController < ApplicationController
  before_action :admin_user, except: [:index, :show]

  def index
    @subjects = Subject.paginate page: params[:page], per_page: 3, limit: 3
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
      redirect_to @subject
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
      redirect_to @subject
    else
      flash.now[:error] = "error in create subject"
      render "edit"
    end
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:success] = "Subject Deleted!"
    redirect_to subjects_url
  end

  private
  def admin_user
    redirect_to root_url unless signed_in? && current_user.admin?
  end

  private
  def subject_params
    params.require(:subject).permit(:subject)
  end
end
