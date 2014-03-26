class Subject < ActiveRecord::Base
  has_many :exams_subjects
  has_many :exams, through: :exams_subjects
  has_many :questions

  validates :name, length: { minimum: 6 }  
end
