require 'rails_helper'

describe Tasks::Import::TdsystemCrawler do
  describe '::crawl' do
    before do
      stubs = Faraday::Adapter::Test::Stubs.new
      stubs.get('/JAPANMASTERS2012/001.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_breast_stroke_100m_woman_2012.html')] }
      stubs.get('/JapanMasters/2013/001.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_breast_stroke_100m_woman_2013.html')] }
      stubs.get('/Masters/JM2014/001.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_breast_stroke_100m_woman_2014.html')] }
      stubs.get('/Masters/JM2015/001.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_breast_stroke_100m_woman_2015.html')] }
      stubs.get('/Masters/JM2016/001.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_free_style_400m_woman_2016.html')] }
      stubs.get('/Masters/JM2016/007.HTM') { |_env| [200, {}, read_fixture_file('tdsystem_free_style_relay_200m_2016.html')] }
      stubs.get('/Record.php?G=4&P=1&S=1') { |_env| [200, {}, read_fixture_file('tdsystem_breast_stroke_100m_woman_2017.html')] }
      test = Faraday.new { |builder| builder.adapter :test, stubs }
      allow(Faraday).to receive(:new) { test }

      described_class.crawl(year: year, page: page)
    end

    after { sleep 1 }

    subject { Result.all.count }

    context 'when year is 2011' do
      let(:year) { 2011 }
      let(:page) { 1 }

      it { is_expected.to be_zero }
    end

    context 'when year is 2012' do
      let(:year) { 2012 }
      let(:page) { 1 }

      it { is_expected.to be_positive }
    end

    context 'when year is 2013' do
      let(:year) { 2013 }
      let(:page) { 1 }

      it { is_expected.to be_positive }
    end

    context 'when year is 2014' do
      let(:year) { 2014 }
      let(:page) { 1 }

      it { is_expected.to be_positive }
    end

    context 'when year is 2015' do
      let(:year) { 2015 }
      let(:page) { 1 }

      it { is_expected.to be_positive }
    end

    context 'when year is 2016' do
      let(:year) { 2016 }
      let(:page) { 1 }

      it { is_expected.to be_positive }

      context 'when page is relay race' do
        let(:page) { 7 }

        it { is_expected.to be_zero }
      end

      context 'when results are already exist' do
        before { described_class.crawl(year: year, page: page) }
        it { is_expected.to be_positive }
      end
    end

    context 'when year is 2017' do
      let(:year) { 2017 }
      let(:page) { 1 }

      it { is_expected.to be_positive }
    end
  end
end
