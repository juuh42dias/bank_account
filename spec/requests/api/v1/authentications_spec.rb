require 'rails_helper'

RSpec.describe 'Api::V1::Authentications', type: :request do
  describe 'POST /api/v1/auth/login' do
    let(:user) { create(:user) }

    context 'with valid user' do
      it 'returns a token)' do
        post api_v1_auth_login_path, params: { email: user.email, password: user.password }
        expect(response.body['token']).not_to be_empty
      end
    end

    context 'with invalid user' do
      it 'returns an unauthorized error' do
        post api_v1_auth_login_path, params: { email: 'vovozinha@email.com', password: '123' }
        expect(json_response['error']['message']).to eq('Usuário(a) não autenticado(a)')
      end
    end
  end
end
