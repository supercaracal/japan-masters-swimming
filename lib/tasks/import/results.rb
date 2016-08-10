module Tasks
  module Import
    class Results
      HOST = 'http://www.tdsystem.co.jp'.freeze
      MIN_YEAR = 2014
      MIN_PAGE = 1
      MAX_PAGE = 34
      SLEEP_SEC = 0.1

      def initialize
        @conn = Faraday.new(url: HOST)
        @team_collection = TeamCollection.new
        @event_collection = EventCollection.new
        @swimmer_collection = SwimmerCollection.new
        @result_collection = ResultCollection.new
      end

      def execute(year: nil, page: nil, now: Time.zone.now)
        (Array.wrap(year).presence || (MIN_YEAR..now.year)).each do |year_|
          (Array.wrap(page).presence || (MIN_PAGE..MAX_PAGE)).each do |page_|
            fetch_and_build_models(year_, page_)
          end
        end
        import_models
      end

      private

      def fetch_and_build_models(year, page)
        Rails.logger.info("Fetch year:#{year} page:#{page}")
        html = fetch(year, page)
        sleep SLEEP_SEC
        data = PageScraper.new(html)
        build_models(data, year)
      rescue PageScraper::ScrapingError => err
        Rails.logger.warn("Failed to scrape at year:#{year} page:#{page}. #{err.message}")
      end

      def fetch(year, page)
        path = "/Masters/JM#{year}/#{format('%03d', page)}.HTM"
        response = @conn.get(path)
        raise "Failed to access at #{HOST}#{path}." unless response.success?
        response.body
      end

      def build_models(page, year)
        event = @event_collection.find_or_build(page.event_name)
        page.results.each do |page_result|
          team = @team_collection.find_or_build(page_result.team)
          swimmer = @swimmer_collection.find_or_build(team, page_result.swimmer)
          @result_collection.find_or_build(swimmer, event, year, page_result.time)
        end
      end

      def import_models
        ApplicationRecord.transaction do
          @event_collection.import!
          @team_collection.import!
          @swimmer_collection.import!
          @result_collection.import!
        end
      end
    end
  end
end
