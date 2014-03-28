class ExaminationsController < ApplicationController
  before_action :signed_in_user

  def index    
    @examinations = current_user.examinations.paginate(page: params[:page], 
      per_page: 15, order: "created_at DESC")
  end
 
  def create
    @examination = current_user.examinations
      .create subject_id: params[:subject_id]
    redirect_to edit_examination_path @examination
  end

  def edit
    @examination = Examination.find params[:id]
  end

  def show
    @examination = Examination.find params[:id]
  end
end
