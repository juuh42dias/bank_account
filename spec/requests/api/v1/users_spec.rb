require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:user) { build(:user) }
    it 'return created user' do
      post api_v1_users_path, params: { user: { name: user.name,
                                                email: user.email,
                                                password: user.password } }

      expect(response).to have_http_status(201)
    end
  end

  describe 'GET /api/v1/users/:id' do
    let(:user) { create(:user) }
    let(:token) { generate_token(user) }

    context 'with logged user' do
      it 'returns a json with user data' do
        get api_v1_user_path(user), headers: { authorization: token }
        expect(json_response['email']).to eq(user.email)
      end
    end

    context 'with not logged user' do
      it 'returns an unauthorized message error' do
        get api_v1_user_path(user)

        expect(json_response['error']['message']).to eq('Usuário(a) não autenticado(a)')
      end
    end
  end
end
