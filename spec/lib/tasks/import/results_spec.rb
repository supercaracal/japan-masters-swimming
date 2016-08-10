require 'rails_helper'

describe 'Tasks::Import::Results' do
  let(:task) { Tasks::Import::Results.new }
  let(:page) { 1 }

  context 'when page exists' do
    before { task.execute(year: year, page: page) }

    context 'when year is 2014' do
      let(:year) { 2014 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'when year is 2015' do
      let(:year) { 2015 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end
    end

    context 'when year is 2016' do
      let(:year) { 2016 }
      describe '#execute' do
        subject { Result.all.count }
        it { is_expected.to be_positive }
      end

      context 'when page is relay race' do
        let(:page) { 7 }
        describe '#execute' do
          subject { Result.all.count }
          it { is_expected.to be_zero }
        end
      end
    end
  end

  context 'when page not exists' do
    subject { -> { task.execute(year: year, page: page) } }
    shared_examples 'Raise Error' do
      describe '#execute' do
        it { is_expected.to raise_error(RuntimeError, /Failed to access at http:/) }
      end
    end

    context 'when year is 2013' do
      let(:year) { 2013 }
      include_examples 'Raise Error'
    end

    context 'when year is future' do
      let(:year) { 1.year.since.year }
      include_examples 'Raise Error'
    end
  end
end
