require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Tasks::Import::TdsystemScraper do
  let(:scraper) { described_class.new }
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
        OpenStruct.new(swimmer: '山田三郎', team: 'だんごSC', time: 93.9),
        OpenStruct.new(swimmer: '山田花太郎', team: 'ダ・埼玉', time: 100.37)
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
        ------------------------------------------------------------ ここまで入賞<BR>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　&nbsp;　山田　花太郎　　　(ダ・埼玉　　)<B>　1:40.37</B>&nbsp;</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end

  context 'When no one win a prize' do
    let(:event_name) { '女子400m自由形' }
    let(:results) do
      [
        OpenStruct.new(swimmer: '六波羅探題', team: 'CIA愛国', time: 1576.81)
      ]
    end
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;女子　400m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>85～84歳<BR></font>
        ------------------------------------------------------------ ここまで入賞<BR>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　&nbsp;　六波羅探題　　　(ＣＩＡ愛国　)<B>&nbsp;26:16.81</B>&nbsp;</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end

  context "When athlete swimmer's result included" do
    let(:event_name) { '男子100m自由形' }
    let(:results) do
      [
        OpenStruct.new(swimmer: '萩野公介', team: 'JAPAN', time: 46.39),
        OpenStruct.new(swimmer: '呂布奉先', team: '赤兎愛好会', time: 46.51),
        OpenStruct.new(swimmer: '関羽雲長', team: '三国SC', time: 47.02)
      ]
    end
    let(:html) do
      <<-EOS
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>No.&nbsp;13&nbsp;男子　100m&nbsp;自由形　　　　　&nbsp;</font>
        <font face='ＤＦ平成明朝体W7' color='#000000' size='4'>18～24歳<BR></font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　1　萩野　　公介　　　(ＪＡＰＡＮ)<B>　46.39</B>&nbsp;･世界新</font>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　&nbsp;　呂布　　奉先　　　(赤兎愛好会)<B>　46.51</B>&nbsp;･日本新</font>
        ------------------------------------------------------------ ここまで入賞<BR>
        <font face='ＭＳ 明朝' color='#000000' size='3'>　&nbsp;　関羽　　雲長　　　(三国ＳＣ　)<B>　47.02</B>&nbsp;･大会新</font>
      EOS
    end

    include_examples 'Can get scraped data'
  end
end
