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

    (Array.wrap(args[:year]).presence || (2012..2016)).each do |year|
      (Array.wrap(args[:page]).presence || (1..34)).each do |page|
        path = "#{paths[year]}/#{format('%03d', page)}.HTM"
        processor.execute(path, year)
      end
    end
  end
end
