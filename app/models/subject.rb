class Subject < ActiveRecord::Base
  has_many :exams_subjects
  has_many :exams, through: :exams_subjects
  has_many :questions

  validates :name, length: { minimum: 6 }  

  def total_questions_by exam_id
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
end
