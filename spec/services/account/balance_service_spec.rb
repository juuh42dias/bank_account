require 'rails_helper'

RSpec.describe Account::BalanceService do

  subject { described_class }

  describe '#execute!' do
    let!(:user) { create(:user) }
    let!(:account) { create(:account, user: user) }

    before do
      account.deposit!(amount: 30.25)
    end

    it 'create an account object' do
      balance = subject.new({account_id: account.id}, user)

      expect(balance.execute!).to eq("R$ 30,25")
    end

    context 'with invalid data' do
      it 'returns an account invalid message error' do
        balance = subject.new({account_id: 0}, user)
        expect { balance.execute! }.to raise_error("Conta Nº 0 não foi encontrada")
      end
    end
  end
end