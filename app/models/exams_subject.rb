class ExamsSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :exam

  validates :total_questions, numericality: { only_integer: true}
  validates :time_limit, numericality: { only_integer: true}
  validates :total_questions, presence: true
  validates :time_limit, presence: true
  before_save :convert_time_to_second
  scope :find_by_ids, ->(ids) { where(id: ids) }

  def convert_time_to_second
  	self.time_limit = self.time_limit * 60
  end
end
