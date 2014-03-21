class AnswersSheetDetail < ActiveRecord::Base
  belongs_to :question
  belongs_to :answers_sheet
  has_many :user_answers
  attr_accessor :correct
  accepts_nested_attributes_for :user_answers
  
  after_find :check_correct

  def check_correct
    user_answers    = self.user_answers.pluck :answer_id
    correct_answers = self.question.answers.correct_answers.ids
    self.correct = true if user_answers == correct_answers
  end
end
