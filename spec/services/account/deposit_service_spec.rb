require 'rails_helper'

RSpec.describe Account::DepositService do

  subject { described_class }

  describe '#execute!' do
    let!(:account) { create(:account) }

    it 'create an account object' do
      deposit = subject.new(account_id: account.id, amount: 250.40)

      expect(deposit.execute!).to eq('R$ 250,40')
    end

    context 'with invalid data' do
      it 'returns an account invalid message error' do
        deposit = subject.new(account_id: 0, amount: 50)
        expect { deposit.execute! }.to raise_error('Conta Nº 0 não foi encontrada')
      end

      it 'returns a amount invalid message error' do
        deposit = subject.new(account_id: account.id, amount: -50)

        expect { deposit.execute! }.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Amount deve ser maior ou igual a 0')
      end
    end
  end
end