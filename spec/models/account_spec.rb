require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { described_class.new }

  it { should belong_to(:user) }
  it { should have_many(:account_transactions).dependent(:destroy) }

  context 'with valid amount' do
    describe '#deposit!' do
      it { expect(subject.deposit!(amount: '50')).to be_truthy }
    end

    describe '#withdraw!' do
      it { expect(subject.withdraw!(amount: 30.45)).to be_truthy }
    end

    describe '#balance' do
      it 'returns a computed balance' do
        subject.deposit!(amount: 350)
        subject.withdraw!(amount: 100)
        expect(subject.balance).to eq(250)
      end
    end
  end

  context 'with invalid amount' do
    describe '#deposit!' do
      it 'returns an error message' do
        expect { subject.deposit!(amount: '5oo') }.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Amount não é um número')
      end
    end

    describe '#withdraw!' do
      it 'returns an error message' do
        expect { subject.withdraw!(amount: -30.45) }.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Amount deve ser maior ou igual a 0')
      end
    end
  end

  context 'with no amount deposited' do
    describe '#balance' do
      it 'returns 0 balance count' do
        expect(subject.balance).to eq(0)
      end
    end
  end
end
