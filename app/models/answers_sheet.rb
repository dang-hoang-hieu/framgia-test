class AnswersSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :exam
  has_many   :answers_sheet_details
  accepts_nested_attributes_for :answers_sheet_details

  before_save do |answers_sheet|
    correct_num = 0
    answers_sheet.answers_sheet_details.each do |detail|
      user_answers_ids = detail.user_answers.map do
      	|u_answer| u_answer.answer_id 
      end
      correct_answers_ids = Answer.where(question_id: detail.question_id, 
      	correct_answer: true).ids
      correct_num += 1 if user_answers_ids.equal? correct_answers_ids
    end 
    answers_sheet.result = correct_num
  end
end
