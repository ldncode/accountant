require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:user_id) { users.first }

  describe 'GET users' do

    before { get '/api/v1/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      get '/api/v1/users'
      expect(response).to have_http_status(200)
    end

  end

  describe 'POST users' do
    let(:valid_attributes) {{ email: 'foo@bar.com', password: 'foobar' }}

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['email']).to eq('foo@bar.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do

      before { post '/api/v1/users',  params: { email: 'foo@bar.com', password: "" }  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match("{\"message\":\"Validation failed: Password can't be blank\"}")
      end
    end
  end 
end
