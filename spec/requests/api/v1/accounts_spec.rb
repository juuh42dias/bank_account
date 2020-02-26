require 'rails_helper'

RSpec.describe 'Api::V1::Accounts', type: :request do
  let(:user) { create(:user) }
  let(:token) { generate_token(user) }

  describe 'GET INDEX /api/v1/accounts' do
    let!(:accounts) { create_list(:account, 2, user: user) }

    it 'returns account list' do
      get api_v1_accounts_path, headers: { authorization: token }

      expect(response).to have_http_status(200)
      expect(response.body).to eq(accounts.to_json)
    end

    context 'with invalid data' do
      it 'returns unauthorized message error' do
        get api_v1_accounts_path, headers: { authorization: nil }

        expect(response).to have_http_status(401)
        expect(json_response['error']['message']).to eq('Usuário(a) não autenticado(a)')
      end
    end
  end

  describe 'POST CREATE /api/v1/accounts' do
    it 'returns a new account' do
      post api_v1_accounts_path, params: { amount: 100.50 }, headers: { authorization: token }

      expect(json_response['user_id']).to eq(user.id)
      expect(response).to have_http_status(201)
    end
    context 'with invalid data' do
      it 'returns a invalid amount message error' do
        post api_v1_accounts_path, params: { amount: -100.50 }, headers: { authorization: token }

        expect(json_response['error']['message']).to eq('A validação falhou: Amount deve ser maior ou igual a 0')
        expect(response).to have_http_status(422)
      end

      it 'returns unauthorized message error' do
        post api_v1_accounts_path, params: { amount: 100.50 }, headers: { authorization: nil }

        expect(response).to have_http_status(401)
        expect(json_response['error']['message']).to eq('Usuário(a) não autenticado(a)')
      end
    end
  end

  describe 'POST TRANSFER /api/v1/accounts/transfer' do
    let(:source_account) { create(:account, user: user) }

    let(:destination_user) { create(:user) }
    let(:destination_account) { create(:account, user: destination_user) }

    before do
      source_account.deposit!(amount: 400)
    end

    it 'returns a transferred message' do
      post api_v1_accounts_transfer_path, params: { source_account_id: source_account.id,
                                                    destination_account_id: destination_account.id,
                                                    amount: 350.40 }, headers: { authorization: token }

      expect(response).to have_http_status(200)
      expect(source_account.balance).to eq(49.60)
      expect(destination_account.balance).to eq(350.40)
      expect(json_response['message']).to eq("Transferida a quantia de R$ 350,40 da conta Nº #{source_account.id} para conta Nº #{destination_account.id}")
    end

    it 'returns origin deposited balance' do
      post api_v1_accounts_transfer_path, params: { source_account_id: source_account.id,
                                                    destination_account_id: destination_account.id,
                                                    amount: -350.40 }, headers: { authorization: token }

      expect(response).to have_http_status(422)
      expect(destination_account.balance).to eq(0)
      expect(source_account.balance).to eq(400.0)
    end

    context 'with invalid data' do
      it 'returns account not found message error' do
        post api_v1_accounts_transfer_path, params: { source_account_id: nil,
                                                      destination_account_id: destination_account.id,
                                                      amount: 350.40 }, headers: { authorization: token }
        expect(response).to have_http_status(404)
        expect(json_response['error']['message']).to eq('Conta Nº  não foi encontrada')
      end

      it 'returns amount negative message error' do
        post api_v1_accounts_transfer_path, params: { source_account_id: source_account.id,
                                                      destination_account_id: destination_account.id,
                                                      amount: -350.40 }, headers: { authorization: token }
        expect(response).to have_http_status(422)
        expect(json_response['error']['message']).to eq('A validação falhou: Amount deve ser maior ou igual a 0')
      end

      it 'returns amount character message error' do
        post api_v1_accounts_transfer_path, params: { source_account_id: source_account.id,
                                                      destination_account_id: destination_account.id,
                                                      amount: 'uai' }, headers: { authorization: token }

        expect(response).to have_http_status(422)
        expect(json_response['error']['message']).to eq('A validação falhou: Amount não é um número')
      end

      it 'returns insufficiente balance message error' do
        post api_v1_accounts_transfer_path, params: { source_account_id: source_account.id,
                                                      destination_account_id: destination_account.id,
                                                      amount: 500 }, headers: { authorization: token }

        expect(response).to have_http_status(422)
        expect(json_response['error']['message']).to eq('Saldo insuficiente')
      end
    end
  end

  describe 'GET BALANCE /api/v1/accounts/:account_id/balance' do
    let(:account) { create(:account, user: user) }
    before do
      account.deposit!(amount: 250.38)
    end
    it 'returns current balance from account' do
      get api_v1_accounts_balance_path(account_id: account.id), headers: { authorization: token }

      expect(response).to have_http_status(200)
      expect(json_response['message']).to eq('O saldo atual é de: R$ 250,38')
    end

    context 'with invalid data' do
      it 'returns account not found message error' do
        get api_v1_accounts_balance_path(account_id: 0), headers: { authorization: token }

        expect(response).to have_http_status(404)
        expect(json_response['error']['message']).to eq('Conta Nº 0 não foi encontrada')
      end

      it 'returns unauthorized message error' do
        get api_v1_accounts_balance_path(account_id: account.id), headers: { authorization: nil }

        expect(response).to have_http_status(401)
        expect(json_response['error']['message']).to eq('Usuário(a) não autenticado(a)')
      end
    end
  end

  describe 'POST DEPOSIT /api/v1/accounts/deposit/' do
    let(:account) { create(:account) }

    it 'returns current balanace from account' do
      post api_v1_accounts_deposit_path, params: { account_id: account.id, amount: 50 }

      expect(response).to have_http_status(200)
      expect(json_response['message']).to eq('Depósito de R$ 50,00 efetuado com sucesso')
    end

    context 'with invalid data' do
      it 'returns account not found message error' do
        post api_v1_accounts_deposit_path, params: { account_id: 0, amount: 50 }

        expect(response).to have_http_status(404)
        expect(json_response['error']['message']).to eq('Conta Nº 0 não foi encontrada')
      end

      it 'retuns amount negative invalid data' do
        post api_v1_accounts_deposit_path, params: { account_id: account.id, amount: -50 }

        expect(response).to have_http_status(422)
        expect(json_response['error']['message']).to eq('A validação falhou: Amount deve ser maior ou igual a 0')
      end

      it 'retuns amount character invalid data' do
        post api_v1_accounts_deposit_path, params: { account_id: account.id, amount: 'u41' }

        expect(response).to have_http_status(422)
        expect(json_response['error']['message']).to eq('A validação falhou: Amount não é um número')
      end
    end
  end
end
