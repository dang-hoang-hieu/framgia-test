class AnswersSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :exam
  has_many   :answers_sheet_details
end
