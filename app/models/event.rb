class Event < ApplicationRecord
  has_many :results

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
