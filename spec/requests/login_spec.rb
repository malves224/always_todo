require 'rails_helper'

RSpec.describe "Logins", type: :request do
  let(:params) { { email: 'matheus@email.com', password: 'password' } }
  let!(:user) { create(:user, email: 'matheus@email.com') }

  describe 'POST /login' do
    it 'returns a 200 status code with token' do
      post '/login', params: params
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(user.id)
      expect(parsed_response).to include('token')
    end

    context 'with invalid email' do
      it 'returns a 401 status code with errors' do
        post '/login', params: { email: 'invalid@email.com', password: 'invalidpassword' }
        expect(response).to have_http_status(:unauthorized)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq([I18n.t('login_controller.errors.invalid_login')])
      end
    end

    context 'with invalid password' do
      it 'returns a 401 status code with errors' do
        post '/login', params: { email: 'matheus@email.com', password: 'invalidpassword' }
        expect(response).to have_http_status(:unauthorized)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq([I18n.t('login_controller.errors.invalid_login')])
      end
    end
  end
end
