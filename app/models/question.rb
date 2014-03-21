class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  belongs_to :level
  belongs_to :subject
  has_one :answers_sheet_detail
  
  scope :find_by_subject, -> (subject_id) { where(subject_id: subject_id) }
  validates :question, length: { minimum: 6 }
end
