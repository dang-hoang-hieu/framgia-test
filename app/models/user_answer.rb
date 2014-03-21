class UserAnswer < ActiveRecord::Base
	belongs_to :answers_sheet_detail
	belongs_to :answer
	validates :answer_id, presence: true
	attr_accessor :checked_by_user
	after_find { |user_answer| user_answer.checked_by_user = true }
end
