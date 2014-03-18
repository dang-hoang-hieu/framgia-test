class Admin::SessionsController < Admin::AdminsController
  before_action :signed_in_admin, only: :destroy

  def new
  end

  def create
    admin = Admin.find_by_email params[:session][:email].downcase
    if admin && admin.authenticate(params[:session][:password])      
      sign_admin_in admin
      flash[:success] = "Sign in successfully"      
      redirect_back_or admin
    else
      flash.now[:error] = "email or password is incorrect"
      session.delete :return_to
      render 'admin_new'
    end   
  end

  def destroy
    sign_admin_out
    redirect_to root_url
  end
end
