namespace :import do
  desc 'Import Japan Masters Swimming Results'
  task :results, %i[year page] => :environment do |_task, args|
    year = args[:year].present? ? args[:year].to_i : nil
    page = args[:page].present? ? args[:page].to_i : nil
    Tasks::Import::TdsystemCrawler.crawl(year: year, page: page)
  end
end
