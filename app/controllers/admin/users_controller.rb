class Admin::UsersController < Admin::AdminsController
  before_action :signed_in_admin
  before_action :correct_admin, only: [:edit, :update]
  
  def index
    @users = User.paginate page: params[:page]
  end

  def show 
    @admin = Admin.find params[:id]
  end

  def edit
  end

  def update 
    if @admin.update_attributes admin_params
      flash[:success] = "Profile Updated"
      redirect_to @admin
    else
      render "edit"
    end
  end

  private
  def admin_params
    params.require(:admin).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  private
  def correct_admin
    @admin = Admin.find params[:id]
    redirect_to root_url unless current_admin? @admin
  end
end
