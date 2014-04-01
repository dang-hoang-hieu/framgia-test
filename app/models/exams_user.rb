class ExamsUser < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user
  
  def examinations
    Examination.where(user_id: user_id, exam_id: exam_id)
  end
end
