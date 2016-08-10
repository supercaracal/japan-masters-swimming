class Swimmer < ApplicationRecord
  belongs_to :team
  has_many :results

  validates :name, presence: true, uniqueness: { scope: :team }, length: { maximum: 255 }
end
