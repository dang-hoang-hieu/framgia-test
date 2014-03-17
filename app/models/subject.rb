class Subject < ActiveRecord::Base
  has_and_belongs_to_many :exams
  has_many :questions

  validates :subject, length: { minimum: 6 }  
end
