class AnswersSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :exam
  has_many   :answers_sheet_details
  accepts_nested_attributes_for :answers_sheet_details
  before_update :calculate_correct_answer, if: :have_answers_sheet_detail?
  before_create :set_status_to_pending, unless: :have_answers_sheet_detail?  

  PENDING = 0
  SUCCESS = 1
  ASSERTED = 2

  private
  def calculate_correct_answer
    correct_num = 0
    self.answers_sheet_details.each do |detail|
      if self.status.to_i == SUCCESS
        user_answers    = detail.user_answers.pluck :checked
        correct_answers = detail.question.answers.correct_answers.ids
          
        correct_num += 1 if user_answers == correct_answers
      else
        correct_num += 1 if detail.correct.to_i > 0
      end
    end
    self.result = correct_num
  end

  private
  def have_answers_sheet_detail?
    self.answers_sheet_details.size > 0
  end

  private
  def set_status_to_pending    
    self.status = PENDING
  end
end
