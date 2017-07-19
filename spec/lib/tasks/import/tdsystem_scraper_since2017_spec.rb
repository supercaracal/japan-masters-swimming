require 'rails_helper'

describe Tasks::Import::TdsystemScraperSince2017 do
  let(:html) do
    File.open(Rails.root.join('spec', 'fixtures', 'tdsystem_freestyle_100m_man_2017.html'), &:read)
  end

  describe '#scrape' do
    let(:expected_results) do
      [
        OpenStruct.new(swimmer: '細川大輔', team: 'K-AQUA', time: 53.70),
        OpenStruct.new(swimmer: '春日太志', team: 'K-AQUA', time: 66.63),
        OpenStruct.new(swimmer: '原田将平', team: 'K-AQUA', time: 53.93)
      ]
    end

    let(:scraped_data) { described_class.new.scrape(html) }

    it 'should get scraped data' do
      aggregate_failures do
        expect(scraped_data.event_name).to eq '男子100m自由形'
        expect(scraped_data.results).to include(*expected_results)
      end
    end
  end
end
