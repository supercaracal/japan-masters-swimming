# rubocop:disable Metrics/BlockLength
namespace :import do
  desc 'Import Japan Masters Swimming Results'
  task :results, %i(year page) => :environment do |_task, args|
    paths = {
      2012 => '/JAPANMASTERS2012',
      2013 => '/JapanMasters/2013',
      2014 => '/Masters/JM2014',
      2015 => '/Masters/JM2015',
      2016 => '/Masters/JM2016'
    }

    host = 'http://www.tdsystem.co.jp'
    scraper = Tasks::Import::TdsystemScraper.new
    processor = Tasks::Import::Results.new(host, scraper)
    year_range = 2012..2016
    page_range = 1..34
    sleep_sec = 0.1

    (Array.wrap(args[:year]).presence || year_range).each do |year|
      year = year.to_i
      raise "Out of range year in #{year_range}" unless year.in?(year_range)
      (Array.wrap(args[:page]).presence || page_range).each do |page|
        page = page.to_i
        raise "Out of range page in #{page_range}" unless page.in?(page_range)
        path = "#{paths[year]}/#{format('%03d', page)}.HTM"
        Rails.logger.info("Fetch #{host}#{path}")
        processor.execute(path, year)
        sleep sleep_sec
      end
    end
  end
end
