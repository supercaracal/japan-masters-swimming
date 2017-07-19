require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Tasks::Import::TdsystemCrawler do
  describe '::crawl' do
    before { described_class.crawl(year: year, page: page) }
    subject { Result.all.count }

    context 'When year is 2011' do
      let(:year) { 2011 }
      let(:page) { 1 }
      it { is_expected.to be_zero }
    end

    context 'When year is 2012' do
      let(:year) { 2012 }
      let(:page) { 1 }
      it { is_expected.to be_positive }
    end

    context 'When year is 2013' do
      let(:year) { 2013 }
      let(:page) { 1 }
      it { is_expected.to be_positive }
    end

    context 'When year is 2014' do
      let(:year) { 2014 }
      let(:page) { 1 }
      it { is_expected.to be_positive }
    end

    context 'When year is 2015' do
      let(:year) { 2015 }
      let(:page) { 1 }
      it { is_expected.to be_positive }
    end

    context 'When year is 2016' do
      let(:year) { 2016 }
      let(:page) { 1 }
      it { is_expected.to be_positive }

      context 'When page is relay race' do
        let(:page) { 7 }
        it { is_expected.to be_zero }
      end

      context 'When results are already exist' do
        before { described_class.crawl(year: year, page: page) }
        it { is_expected.to be_positive }
      end
    end

    context 'When year is 2017' do
      let(:year) { 2017 }
      let(:page) { 1 }
      it { is_expected.to be_positive }
    end
  end
end
