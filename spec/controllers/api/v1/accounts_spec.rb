require 'rails_helper'

RSpec.describe 'Accounts API', type: :request do
  let!(:user) { create(:user) }
  let!(:accounts) { create_list(:account, 3, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { accounts.first.id }

  describe 'GET /api/v1/users/:user_id/accounts' do
    before { get "/api/v1/users/#{user_id}/accounts" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user accounts' do
        expect(json.size).to eq(3)
      end
    end
  end

end
