class Result < ApplicationRecord
  belongs_to :swimmer
  belongs_to :event

  validates :year, presence: true, uniqueness: { scope: %i(event swimmer) }, length: { maximum: 4 }, numericality: { only_integer: true, greater_than_or_equal_to: 2014 }
  validates :time, presence: true, length: { maximum: 11 }, numericality: { greater_than: 0.0 }

  def time_text
    seconds = time.truncate
    minute = seconds / 60
    second = format('%02d', seconds % 60)
    millisecond = format('%.2f', time).split('.').second
    if minute.zero?
      "#{second}.#{millisecond}"
    else
      "#{minute}:#{second}.#{millisecond}"
    end
  end
end
