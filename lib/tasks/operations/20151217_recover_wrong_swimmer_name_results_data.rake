namespace :operations do
  desc 'Recover wrong swimmer name results #2'
  task '20151217_recover_wrong_swimmer_name_results_data' => :environment do
    wrong_text = '------------------------------------------------------------ここまで入賞'
    Swimmer.where('name LIKE :name', name: '%ここまで%').includes(:results, :team).each do |wrong_swimmer|
      proper_swimmer = Swimmer.find_by(name: wrong_swimmer.name.gsub(wrong_text, ''), team: wrong_swimmer.team)
      wrong_swimmer.results.each do |result|
        result.update!(swimmer: proper_swimmer)
      end
      wrong_swimmer.destroy
    end
  end
end
