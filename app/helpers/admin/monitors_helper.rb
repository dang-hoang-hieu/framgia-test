module Admin::MonitorsHelper
  def convert_to_csv(class_model, options = {})
    CSV.generate(options) do |csv|
      csv << class_model.constantize.column_names
      class_model.constantize.all.each do |data|
        csv << data.attributes.values_at(*class_model.constantize.column_names)
      end
    end
  end

  def import_csv(class_model, file)
    CSV.foreach(file.path, headers: true) do |row|
      record = class_model.constantize.where(
        :id => row[0]
      ).first_or_create row.to_hash
    end
  end
end