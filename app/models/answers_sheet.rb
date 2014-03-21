class AnswersSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :exam
  has_many   :answers_sheet_details
  accepts_nested_attributes_for :answers_sheet_details
  before_save :filter_answer_checked_by_user
  before_save :calculate_correct_answer
  
  private
  def calculate_correct_answer
    correct_num = 0
    self.answers_sheet_details.each do |detail|
      if self.status.to_i == 1
        user_answers    = detail.user_answers.pluck :answer_id
        correct_answers = detail.question.answers
          .correct_answers.ids
          
        correct_num += 1 if user_answers == correct_answers
      else
        correct_num += 1 if detail.correct.to_i > 0
      end
    end
    self.result = correct_num
  end
 
  private 
  def filter_answer_checked_by_user
    self.answers_sheet_details.map do |detail|
      detail.user_answers.map do |ans|
        ans.delete if ans.answer_id == 0
      end 
    end
  end
end
