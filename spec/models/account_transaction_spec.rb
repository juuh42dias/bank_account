require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  subject { described_class.new }

  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  it { should belong_to(:account) }

  describe 'TYPES' do
    it { expect(AccountTransaction::TYPES['WITHDRAW']).to eq('Saque') }
    it { expect(AccountTransaction::TYPES['DEPOSIT']).to eq('Depósito') }
  end

  context 'account transaction scopes' do
    describe '.deposit' do
      let!(:account_transaction_deposit) { create(:account_transaction, :deposit) }

      it 'returns deposit transactions list' do
        expect(described_class.deposit).to eq([account_transaction_deposit])
      end
    end

    describe '.withdraw' do
      let!(:account_transaction_withdraw) { create(:account_transaction, :withdraw) }

      it 'returns withdraw transactions list' do
        expect(described_class.withdraw).to eq([account_transaction_withdraw])
      end
    end

    let!(:account) { create(:account) }

    describe '.deposit_by_account' do
      let!(:account_transaction_deposit_by_account) { create(:account_transaction, :deposit, account: account) }

      it 'returns deposit_by_account transactions list' do
        expect(described_class.deposit_by_account(account)).to eq([account_transaction_deposit_by_account])
      end
    end

    describe '.withdraw_by_account' do
      let!(:account_transaction_withdraw_by_account) { create(:account_transaction, :withdraw, account: account) }

      it 'returns withdraw_by_account transactions list' do
        expect(described_class.withdraw_by_account(account)).to eq([account_transaction_withdraw_by_account])
      end
    end
  end
end
