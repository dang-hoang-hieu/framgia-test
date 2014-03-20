class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  belongs_to :level
  belongs_to :subject
  has_one :answers_sheet_detail
  
  validates :question, length: { minimum: 6 }
end
