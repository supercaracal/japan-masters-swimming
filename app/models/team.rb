class Team < ApplicationRecord
  has_many :swimmers, dependent: :restrict_with_exception
  has_many :results, through: :swimmers

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
