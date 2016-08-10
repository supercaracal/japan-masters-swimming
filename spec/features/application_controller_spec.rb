require 'rails_helper'

feature 'GET /' do
  given(:path) { root_path }
  background do
    event = FactoryGirl.create(:event)
    team = FactoryGirl.create(:team)
    swimmer = FactoryGirl.create(:swimmer, team: team)
    FactoryGirl.create(:result, swimmer: swimmer, event: event)
    visit path
  end

  feature 'Can link to teams' do
    scenario 'Success to view top' do
      expect(page).to have_content 'Teams'
    end
  end

  feature 'GET /teams' do
    background { click 'Teams' }
    scenario 'Success to view teams' do
      expect(page).to have_content 'JAPAN'
    end
  end
end
