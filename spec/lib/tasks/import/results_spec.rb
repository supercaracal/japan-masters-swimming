require 'rails_helper'

describe 'Tasks::Import::Results' do
  let(:task) { Tasks::Import::Results.new }
  let(:page) { 1 }
  before { task.execute(year: year, page: page) }

  context 'when year 2014' do
    let(:year) { 2014 }
    describe '#execute' do
      subject { Result.all.count }
      it { is_expected.to be_positive }
    end
  end

  context 'when year 2015' do
    let(:year) { 2015 }
    describe '#execute' do
      subject { Result.all.count }
      it { is_expected.to be_positive }
    end
  end

  context 'when year 2016' do
    let(:year) { 2016 }
    describe '#execute' do
      subject { Result.all.count }
      it { is_expected.to be_positive }
    end
  end
end
