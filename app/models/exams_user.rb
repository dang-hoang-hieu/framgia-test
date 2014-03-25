class ExamsUser < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user
end
