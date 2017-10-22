require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'GET /', type: :feature do
  let(:path) { root_path }

  before do
    event = FactoryGirl.create(:event)
    event_free = FactoryGirl.create(:event, name: '男子100m自由形')
    team = FactoryGirl.create(:team)
    swimmer = FactoryGirl.create(:swimmer, team: team)
    FactoryGirl.create(:result, swimmer: swimmer, event: event)
    FactoryGirl.create(:result, swimmer: swimmer, event: event_free, time: 46.91)
    visit path
  end

  describe 'Can link to teams' do
    it 'Success to view top' do
      expect(page).to have_content 'Teams'
    end
  end

  describe 'GET /teams' do
    before { click_link 'Teams' }
    it 'Success to view teams' do
      expect(page).to have_content 'JAPAN'
    end
  end

  describe 'GET /teams/:team_id/swimmers' do
    before do
      click_link 'Teams'
      click_link 'JAPAN'
    end
    it 'Success to view swimmers' do
      expect(page).to have_content '萩野公介'
    end
  end

  describe 'GET /swimmers/:swimmer_id/results' do
    before do
      click_link 'Teams'
      click_link 'JAPAN'
      click_link '萩野公介'
    end
    it 'Success to view results' do
      aggregate_failures do
        expect(page).to have_content '男子200m自由形'
        expect(page).to have_content '1:46.19'
        expect(page).to have_content '男子100m自由形'
        expect(page).to have_content '46.91'
      end
    end
  end
end
