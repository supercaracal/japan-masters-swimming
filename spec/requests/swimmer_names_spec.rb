require 'rails_helper'

describe 'GET /swimmer_names', type: :request do
  before do
    team = FactoryGirl.create(:team, name: '鯖の塩焼き')
    FactoryGirl.create(:swimmer, team: team, name: '山田太郎')
    FactoryGirl.create(:swimmer, team: team, name: '伊藤次郎')
    get "#{swimmer_names_path}?#{CGI.escape('swimmer[name]')}=#{CGI.escape(name_prefix)}"
  end

  subject { response.body }

  context 'when swimmer is exist' do
    let(:name_prefix) { '山' }

    it { is_expected.to include('山田太郎 鯖の塩焼き') }
  end

  context 'when swimmer is not exist' do
    let(:name_prefix) { '川' }

    it { is_expected.to be_blank }
  end

  context 'when prefix is not specified' do
    let(:name_prefix) { '' }

    it { is_expected.to be_blank }
  end
end
