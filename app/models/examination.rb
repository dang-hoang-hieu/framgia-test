class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :answers_sheets, dependent: :destroy
  belongs_to :subject
  def remove_trash
    unless self.exam_id? || self.answers_sheets.present?
      self.destroy
    end
  end
end
