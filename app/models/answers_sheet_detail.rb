class AnswersSheetDetail < ActiveRecord::Base
	belongs_to :question
	belongs_to :answers_sheet
	has_many :user_answers
	accepts_nested_attributes_for :user_answers
end
