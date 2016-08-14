module Tasks
  module Import
    class Results
      def initialize(host, scraper, sleep_sec: 0.1)
        @host = host.freeze
        @scraper = scraper
        @sleep_sec = sleep_sec
        @conn = Faraday.new(url: @host)
        @team_collection = TeamCollection.new
        @event_collection = EventCollection.new
        @swimmer_collection = SwimmerCollection.new
        @result_collection = ResultCollection.new
      end

      def execute(path, year)
        Rails.logger.info("Fetch #{@host}#{path}")
        html = fetch_page(path)
        data = @scraper.scrape(html)
        build_models(data, year)
        import_models
      rescue ScrapingError => err
        Rails.logger.warn("Failed to scrape. Caused by #{err.message}.")
      end

      private

      def fetch_page(path)
        response = @conn.get(path)
        raise "Failed to access at #{@host}#{path}." unless response.success?
        sleep @sleep_sec
        response.body
      end

      def build_models(data, year)
        event = @event_collection.find_or_build(data.event_name)
        data.results.each do |result|
          team = @team_collection.find_or_build(result.team)
          swimmer = @swimmer_collection.find_or_build(team, result.swimmer)
          @result_collection.find_or_build(swimmer, event, year, result.time)
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
