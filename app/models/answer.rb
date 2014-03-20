class Answer < ActiveRecord::Base
  belongs_to :question
  has_one :user_answer
  validates :answer, length: { minimum: 6 }
end
