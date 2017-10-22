class Event < ApplicationRecord
  TOP10 = <<-SQL.freeze
    SELECT
      sub.*
    FROM (
      SELECT
        RANK() OVER (PARTITION BY events.id ORDER BY results.time ASC) AS no,
        events.name AS event_name,
        teams.id AS team_id,
        teams.name AS team_name,
        swimmers.id AS swimmer_id,
        swimmers.name AS swimmer_name,
        results.time AS time
      FROM
        events
          INNER JOIN (SELECT event_id, swimmer_id, MIN(time) AS time FROM results GROUP BY event_id, swimmer_id) AS results ON events.id = results.event_id
          INNER JOIN swimmers ON results.swimmer_id = swimmers.id
          INNER JOIN teams ON swimmers.team_id = teams.id
    ) AS sub
    WHERE
      sub.no <= 10
  SQL

  has_many :results, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  class << self
    def fetch_ranks
      connection
        .select_all(TOP10)
        .to_hash
        .map { |row| OpenStruct.new(row) }
        .group_by(&:event_name)
    end
  end
end
