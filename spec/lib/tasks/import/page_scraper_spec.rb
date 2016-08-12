require 'rails_helper'

describe 'Tasks::Import::PageScraper' do
  let(:scraper) { Tasks::Import::PageScraper.new(html) }

  shared_examples 'Can get scraped data' do
    describe 'Can get a event name' do
      subject { scraper.event_name }
      it { is_expected.to eq event_name }
    end

    describe 'Can get results' do
      subject { scraper.results }
      it { is_expected.to include(OpenStruct.new(swimmer: swimmer_name, team: team_name, time: time)) }
    end
  end

  context "When hobby swimmer's result included" do
    let(:event_name) { '男子100m自由形' }
    let(:team_name) { 'さいたまSC' }
    let(:swimmer_name) { '山田花太郎' }
    let(:time) { 89.51 }
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;男子　100m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　1　山田　花太郎　　　(さいたまＳＣ)<B>　1:29.51</B>&nbsp;</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end

  context "When athlete swimmer's result included" do
    let(:event_name) { '男子100m自由形' }
    let(:team_name) { 'JAPAN' }
    let(:swimmer_name) { '萩野公介' }
    let(:time) { 46.39 }
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;男子　100m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　1　萩野　　公介　　　(ＪＡＰＡＮ)<B>　46.39</B>&nbsp;･世界新</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end
end
