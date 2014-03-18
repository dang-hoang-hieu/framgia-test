class Answer < ActiveRecord::Base
  belongs_to :question

  validates :answer, length: { minimum: 6 }
end
