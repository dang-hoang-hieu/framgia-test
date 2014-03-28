class UserAnswer < ActiveRecord::Base
	belongs_to :answers_sheet_detail
	belongs_to :answer
	validates :answer_id, presence: true
end
