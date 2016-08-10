namespace :import do
  desc 'Import Japan Masters Swimming Results since 2014'
  task :results, %i(year page) => :environment do |_task, args|
    Tasks::Import::Results.new.execute(args)
  end
end
