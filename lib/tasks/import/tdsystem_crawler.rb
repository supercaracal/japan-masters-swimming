module Tasks
  module Import
    class TdsystemCrawler
      HOST = 'http://www.tdsystem.co.jp'.freeze
      PROXY = 'http://133.242.237.206:88'.freeze

      BASE_PATHS = {
        2012 => '/JAPANMASTERS2012',
        2013 => '/JapanMasters/2013',
        2014 => '/Masters/JM2014',
        2015 => '/Masters/JM2015',
        2016 => '/Masters/JM2016',
        2017 => 'Record.php?S=1&G=4&P='
      }.freeze

      YEARS = BASE_PATHS.keys.freeze
      PAGES = 1..34
      SLEEP_SEC = 0.1

      class << self
        def crawl(year: nil, page: nil)
          (Array.wrap(year).presence || YEARS).each do |y|
            next unless y.in?(YEARS)

            (Array.wrap(page).presence || PAGES).each do |p|
              next unless p.in?(PAGES)

              new.scrape_and_save(y, p)

              sleep SLEEP_SEC
            end
          end
        rescue Tasks::Import::ScrapingError => err
          Rails.logger.warn("Failed to scrape. Caused by #{err.message}.")
        end
      end

      def initialize
        @conn = Faraday.new(url: HOST, proxy: PROXY)
        @conn.options.timeout = 10
        @conn.options.open_timeout = 10
        @team_collection = TeamCollection.new
        @event_collection = EventCollection.new
        @swimmer_collection = SwimmerCollection.new
        @result_collection = ResultCollection.new
      end

      def scrape_and_save(year, page)
        path = build_path(year, page)
        html = fetch_page(path)
        scraper = build_scraper(year)
        data = scraper.scrape(html)
        return if data.blank?
        build_models(data, year)
        import_models
      end

      private

      def build_path(year, page)
        if year >= 2017
          "#{BASE_PATHS[year]}#{page}"
        else
          "#{BASE_PATHS[year]}/#{format('%03d', page)}.HTM"
        end
      end

      def build_scraper(year)
        if year >= 2017
          TdsystemScraperSince2017.new
        else
          TdsystemScraper.new
        end
      end

      def fetch_page(path)
        response = @conn.get(path)
        raise "Failed to access at #{HOST}#{path}." unless response.success?
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
