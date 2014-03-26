class Admin::UserListsController < Admin::AdminsController
  before_action :signed_in_admin

  def edit
    @users = User.all
    @exam = Exam.find params[:exam_id]
    @users.each do |user|
      @exam.exams_users.find_or_initialize_by(user_id: user.id)
    end
    render layout: false
  end

  def update
    @exam = Exam.find params[:exam_id]
    if @exam.update_attributes user_list_params
      flash[:success] = "Assign user successfully"
      redirect_to [:admin, @exam]
    else
      flash.now[:error] = "Assign error"
      render "edit"
    end
  end

  private
  def user_list_params
    list_params = params.require(:exam).permit(:user_ids => [])
  end
end
