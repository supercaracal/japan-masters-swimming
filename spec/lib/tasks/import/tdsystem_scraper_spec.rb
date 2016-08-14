require 'rails_helper'

describe 'Tasks::Import::TdsystemScraper' do
  let(:scraper) { Tasks::Import::TdsystemScraper.new }
  let(:data) { scraper.scrape(html) }

  shared_examples 'Can get scraped data' do
    describe 'Can get a event name' do
      subject { data.event_name }
      it { is_expected.to eq event_name }
    end

    describe 'Can get results' do
      subject { data.results }
      it { is_expected.to include(*results) }
    end
  end

  context "When hobby swimmer's result included" do
    let(:event_name) { '男子100m自由形' }
    let(:results) do
      [
        OpenStruct.new(swimmer: '斎藤一', team: '新撰組SC', time: 70.01),
        OpenStruct.new(swimmer: '山田太郎', team: 'だんごSC', time: 89.51),
        OpenStruct.new(swimmer: '山田次郎', team: 'だんごSC', time: 91.29),
        OpenStruct.new(swimmer: '山田三郎', team: 'だんごSC', time: 93.9)
      ]
    end
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;男子　100m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>100～104歳<BR></font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　 　斎藤　一　　　　(新撰組ＳＣ)<B>　1:10.01</B>&nbsp;</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　1　山田　太郎　　　(だんごＳＣ)<B>　1:29.51</B>&nbsp;</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　2　山田　次郎　　　(だんごＳＣ)<B>　1:31.29</B>&nbsp;</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　3　山田　三郎　　　(だんごＳＣ)<B>　1:33.90</B>&nbsp;</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end

  context "When athlete swimmer's result included" do
    let(:event_name) { '男子100m自由形' }
    let(:results) do
      [
        OpenStruct.new(swimmer: '萩野公介', team: 'JAPAN', time: 46.39)
      ]
    end
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;男子　100m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>18～24歳<BR></font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　1　萩野　　公介　　　(ＪＡＰＡＮ)<B>　46.39</B>&nbsp;･世界新</font>
        ------------------------------------------------------------ ここまで入賞<BR>
      EOS
    end

    include_examples 'Can get scraped data'
  end
end
