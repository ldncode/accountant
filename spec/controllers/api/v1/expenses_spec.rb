require 'rails_helper'

RSpec.describe 'Expenses API', type: :request do
  let!(:user) { create(:user) }
  let!(:account) { create(:account,  user_id: user.id) }
  let!(:expenses) { create_list(:expense, 3, account_id: account.id) }
  let(:user_id) { user.id }
  let(:account_id) { account.id }
  let(:id) { expenses.first.id }

  describe 'POST accounts expenses' do
    let(:valid_attributes) { { title: 'MyString', value: 1 } }

    context 'when request attributes are valid' do
      before { post "/api/v1/users/#{user_id}/accounts/#{account_id}/expenses", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/users/#{user_id}/accounts/#{account_id}/expenses", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match "{\"message\":\"Validation failed: Title can't be blank\"}"
      end
    end
  end

  describe 'GET expenses' do
    before { get "/api/v1/users/#{user_id}/accounts/#{account_id}/expenses" }

    context 'when account exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all account expenses' do
        expect(json.size).to eq(3)
      end
    end

    context 'when account does not exist' do
      let(:account_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Account with 'id'=0 [WHERE \\\"accounts\\\".\\\"user_id\\\" = $1]\"}")
      end
    end
  end

  describe 'GET expense' do
    before { get "/api/v1/users/#{user_id}/accounts/#{account_id}/expenses/#{id}" }

    context 'when account expense exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expense' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when account expense does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to eq("{\"message\":\"Couldn't find Expense with [WHERE \\\"expenses\\\".\\\"account_id\\\" = $1 AND \\\"expenses\\\".\\\"id\\\" = $2]\"}")
      end
    end
  end
end
