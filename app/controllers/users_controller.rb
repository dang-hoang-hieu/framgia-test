class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :guest, only: [:new, :create]
  
  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show 
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = "welcome to Framgia testing system!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update 
    if @user.update_attributes user_params
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  private
  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

  private
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
