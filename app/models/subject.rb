class Subject < ActiveRecord::Base
  has_many :exams_subjects
  has_many :exams, through: :exams_subjects
  has_many :questions

  validates :name, length: { minimum: 6 }
  validates :total_questions, numericality: { only_integer: true} 
  validates :time_limit, numericality: { only_integer: true}
  
  before_save :convert_time_to_second
  
  def total_questions exam_id
    if exam_id.present?
      self.exams_subjects.find_by(exam_id: exam_id).total_questions
    else
      self.total_questions
    end
  end

  def time_limit_by exam_id
    if exam_id.present?
      self.exams_subjects.find_by(exam_id: exam_id).time_limit
    else
      self.time_limit
    end
  end

  private
  def convert_time_to_second
    self.time_limit = self.time_limit * 60
  end
end
