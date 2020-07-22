require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:user) { create(:user) }

    # it 'create a new user' do
    #
    #   expect(response).to have_http_status(:created)
    #   expect(JSON.parse(response.body)).to include(expected_body)
    # end
    #
    # it 'return entity with errors' do
    #   user_params[:password] = nil
    #   post api_v1_users_path, params: { user: user_params }
    #
    #   expected_error = { 'password' => ["can't be blank"] }
    #
    #   expect(response).to have_http_status(:unprocessable_entity)
    #   expect(JSON.parse(response.body)).to eq(expected_error)
    # end

  end
end
