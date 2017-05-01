class Result < ApplicationRecord
  belongs_to :swimmer
  belongs_to :event

  validates :year, presence: true, uniqueness: { scope: %i[event swimmer] }, length: { maximum: 4 }, numericality: { only_integer: true, greater_than_or_equal_to: 2012 }
  validates :time, presence: true, length: { maximum: 11 }, numericality: { greater_than: 0.0 }
end
