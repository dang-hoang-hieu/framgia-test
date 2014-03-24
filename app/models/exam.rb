class Exam < ActiveRecord::Base
  has_many :exams_subjects, dependent: :destroy
  has_many :subjects, through: :exams_subjects
  accepts_nested_attributes_for :exams_subjects
  validates :name, presence: true  
end
