require 'rails_helper'

feature 'GET /' do
  given(:path) { root_path }
  background do
    event = FactoryGirl.create(:event)
    event_free = FactoryGirl.create(:event, name: '男子100m自由形')
    team = FactoryGirl.create(:team)
    swimmer = FactoryGirl.create(:swimmer, team: team)
    FactoryGirl.create(:result, swimmer: swimmer, event: event)
    FactoryGirl.create(:result, swimmer: swimmer, event: event_free, time: 46.91)
    visit path
  end

  feature 'Can link to teams' do
    scenario 'Success to view top' do
      expect(page).to have_content 'Teams'
    end
  end

  feature 'GET /teams' do
    background { click_link 'Teams' }
    scenario 'Success to view teams' do
      expect(page).to have_content 'JAPAN swimmers'
    end
  end

  feature 'GET /teams/:team_id/swimmers' do
    background do
      click_link 'Teams'
      click_link 'JAPAN swimmers'
    end
    scenario 'Success to view swimmers' do
      expect(page).to have_content '萩野公介 results'
    end
  end

  feature 'GET /swimmers/:swimmer_id/results' do
    background do
      click_link 'Teams'
      click_link 'JAPAN swimmers'
      click_link '萩野公介 results'
    end
    scenario 'Success to view results' do
      aggregate_failures do
        expect(page).to have_content '男子200m自由形'
        expect(page).to have_content '1:46.19'
        expect(page).to have_content '男子100m自由形'
        expect(page).to have_content '46.91'
      end
    end
  end
end
