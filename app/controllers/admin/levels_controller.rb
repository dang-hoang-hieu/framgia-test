class Admin::LevelsController < Admin::AdminsController
  before_action :signed_in_admin

  def index
    @levels = Level.paginate(page: params[:page], per_page: 3,
     order: "created_at DESC")
  end

  def show
    @level = Level.find params[:id]
  end

  def new
    @level = Level.new
  end

  def create
    @level = Level.new level_params
    if @level.save
      flash[:success] = "create level successfully"
      redirect_to [:admin, @level]
    else
      flash.now[:error] = "error in create level"
      render "new"
    end
  end
  
  def edit
    @level = Level.find params[:id]
  end
  
  def update
    @level = Level.find params[:id]
    if @level.update_attributes(level_params)
      flash[:success] = "update level successfully"
      redirect_to [:admin, @level]
    else
      flash.now[:error] = "error in create level"
      render "edit"
    end
  end

  def destroy
    Level.find(params[:id]).destroy
    flash[:success] = "Level Deleted!"
    redirect_to admin_levels_url
  end

  private
  def level_params
    params.require(:level).permit(:level)
  end
end
