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
end
