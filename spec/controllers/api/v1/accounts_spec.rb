require 'rails_helper'

RSpec.describe 'Accounts API', type: :request do
  let!(:user) { create(:user) }
  let!(:accounts) { create_list(:account, 3, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { accounts.first.id }

  describe 'GET accounts' do
    before { get "/api/v1/users/#{user_id}/accounts" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user accounts' do
        expect(json.size).to eq(3)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find User with 'id'=0\"}")
      end
    end
  end

  describe 'GET account' do
    before { get "/api/v1/users/#{user_id}/accounts/#{id}" }

    context 'when user account exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the account' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user account does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Account with 'id'=0 [WHERE \\\"accounts\\\".\\\"user_id\\\" = $1]\"}")
      end
    end
  end

  describe 'POST users accounts' do
    let(:valid_attributes) { { nickname: 'Kasper' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/users/#{user_id}/accounts", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/users/#{user_id}/accounts", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match("{\"message\":\"Validation failed: Nickname can't be blank\"}")
      end
    end
  end
end
