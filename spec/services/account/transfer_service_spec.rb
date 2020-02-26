require 'rails_helper'

RSpec.describe Account::TransferService do
  subject { described_class }

  describe '#execute' do
    let(:source_user) { create(:user) }
    let(:destination_user) { create(:user) }
    let(:source_account) { create(:account, user: source_user) }
    let(:destination_account) { create(:account, user: destination_user) }

    let(:valid_params) do {
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        amount: '350.25'
      }
    end

    before do
      source_account.deposit!(amount: 500)
    end

    it 'returns amount tranferred' do
      transfer = subject.new(valid_params, source_user)

      expect(transfer.execute!).to eq('R$ 350,25')
    end

    context 'with invalid data' do
      let(:invalid_source_account) do {
          source_account_id: 0,
          destination_account_id: destination_account.id,
          amount: 350.25
        }
      end

      it 'returns source account not found message error' do
        transfer = subject.new(invalid_source_account, source_user)
        expect { transfer.execute! }.to raise_error('Conta Nº 0 não foi encontrada')
      end

      let(:invalid_destination_account) do {
          source_account_id: source_account.id,
          destination_account_id: nil,
          amount: 350.25
        }
      end

      it 'returns destination account not found message error' do
        transfer = subject.new(invalid_destination_account, source_user)
        expect { transfer.execute! }.to raise_error('Conta Nº  não foi encontrada')
      end

      let(:negative_amount) do {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: -350.25
        }
      end

      it 'returns invalid negative amount numericality message error' do
        transfer = subject.new(negative_amount, source_user)
        expect { transfer.execute! }.to raise_error('A validação falhou: Amount deve ser maior ou igual a 0')
      end

      let(:letter_amount) do {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 'u41'
        }
      end

      it 'returns invalid letter amount numericality message error' do
        transfer = subject.new(letter_amount, source_user)
        expect { transfer.execute! }.to raise_error('A validação falhou: Amount não é um número')
      end

      let(:insufficient_amount) do {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 2500
        }
      end

      it 'returns destination account not found message error' do
        transfer = subject.new(insufficient_amount, source_user)
        expect { transfer.execute! }.to raise_error('Saldo insuficiente')
      end
    end
  end
end