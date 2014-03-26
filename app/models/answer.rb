class Answer < ActiveRecord::Base
  belongs_to :question
  has_one :user_answer
  scope :correct_answers, -> { where(correct_answer: true) }
  validates :name, length: { minimum: 6 }
end
