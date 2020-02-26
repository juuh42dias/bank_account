require 'rails_helper'

RSpec.describe Account::CreateService do
  subject { described_class }

  describe '#execute!' do
    let(:user) { create(:user) }

    it 'create an account object' do
      account_service = subject.new({amount: 250.40}, user)
      expect{ account_service.execute! }.to change{ Account.count }.by(1)
    end

    context 'with invalid data' do
      it 'returns an user invalid message error' do
        account_service = subject.new({amount: 50}, nil)

        expect { account_service.execute! }.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: User é obrigatório(a)')
      end

      it 'returns a amount invalid message error' do
        account_service = subject.new({amount: -50}, user)

        expect { account_service.execute! }.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Amount deve ser maior ou igual a 0')
      end
    end
  end
end
