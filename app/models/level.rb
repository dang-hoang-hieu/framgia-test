class Level < ActiveRecord::Base
  has_many :questions

  validates :level, numericality: { only_integer: true}
end
