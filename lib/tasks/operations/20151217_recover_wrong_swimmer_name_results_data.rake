namespace :operations do
  desc 'Recover wrong swimmer name results #2'
  task '20151217_recover_wrong_swimmer_name_results_data' => :environment do
    wrong_text = '------------------------------------------------------------ここまで入賞'
    Swimmer.where('name LIKE :name', name: '%ここまで%').includes(:results, :team).each do |wrong_swimmer|
      proper_name = wrong_swimmer.name.gsub(wrong_text, '')
      proper_swimmer = Swimmer.find_by(name: proper_name, team: wrong_swimmer.team)
      if proper_swimmer.present?
        wrong_swimmer.results.each { |result| result.update!(swimmer: proper_swimmer) }
        wrong_swimmer.destroy
      else
        wrong_swimmer.update!(name: proper_name)
      end
    end
  end
end
