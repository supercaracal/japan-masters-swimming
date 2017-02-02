require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Tasks::Import::Results' do
  let(:host) { 'http://www.tdsystem.co.jp' }
  let(:scraper) { Tasks::Import::TdsystemScraper.new }
  let(:task) { Tasks::Import::Results.new(host, scraper) }

  context 'When page exists' do
    before { task.execute(path, year) }

    context 'When year is 2012' do
      let(:path) { '/JAPANMASTERS2012/001.HTM' }
      let(:year) { 2012 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'When year is 2013' do
      let(:path) { '/JapanMasters/2013/001.HTM' }
      let(:year) { 2013 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'When year is 2014' do
      let(:path) { '/Masters/JM2014/001.HTM' }
      let(:year) { 2014 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'When year is 2015' do
      let(:path) { '/Masters/JM2015/001.HTM' }
      let(:year) { 2015 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'When year is 2016' do
      let(:path) { '/Masters/JM2016/001.HTM' }
      let(:year) { 2016 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end

      context 'When page is relay race' do
        let(:path) { '/Masters/JM2016/007.HTM' }
        describe '#execute' do
          subject { Result.all.count }
          it { is_expected.to be_zero }
        end
      end

      context 'When results are already exist' do
        before { task.execute(path, year) }
        describe '#execute' do
          subject { Result.all.count }
          it { is_expected.to be_positive }
        end
      end
    end
  end

  context 'When page not exists' do
    subject { -> { task.execute(path, year) } }
    shared_examples 'Raise Error' do
      describe '#execute' do
        it { is_expected.to raise_error(RuntimeError, /Failed to access at http:/) }
      end
    end

    context 'When year is 2011' do
      let(:path) { '/Masters/JM2011/001.HTM' }
      let(:year) { 2011 }
      include_examples 'Raise Error'
    end

    context 'When year is future' do
      let(:year) { 1.year.since.year }
      let(:path) { "/Masters/JM#{year}/001.HTM" }
      include_examples 'Raise Error'
    end
  end
end
