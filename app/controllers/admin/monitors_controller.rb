class Admin::MonitorsController < Admin::AdminsController
  before_action :signed_in_admin
  include Admin::MonitorsHelper

  def index
    @tables = Array.new
    ActiveRecord::Base.connection.tables.each do |table|
      @tables << table.camelize.singularize if table != "schema_migrations" &&
       table != "admins"
    end
  end

  def export
    class_model = params[:model]
    respond_to do |format|
      format.csv { send_data convert_to_csv(class_model), filename: "#{class_model}.csv" }
    end
  end

  def import
    class_model = params[:model]
    import_csv(class_model, params[:file])
    redirect_to :back, notice: "#{class_model} imported."
  end
end
