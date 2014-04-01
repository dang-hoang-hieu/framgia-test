class Admin::ExaminationsController < Admin::AdminsController
  before_action :signed_in_admin

  def index
    @exams_users = ExamsUser.paginate(page: params[:page], per_page: 10,
      order: "created_at DESC")
  end
  
  def create
    if Examination.create(user_id: params[:user_id], exam_id: params[:exam_id])
      render layout: false
    else
      flash[:error] = "error in start examination"
      redirect_to admin_examinations_url
    end
  end
  
  def update
    @examination = Examination.find params[:id]
    if @examination.calculate_result
      flash[:success] = "successfully calculate result"
      redirect_to admin_examinations_url
    else
      flash[:error] = "error in calcualte result"
      redirect_to admin_examinations_url	
    end
  end

  def show
    @examination = Examination.find params[:id]
  end
end
