class Account < ApplicationRecord
  belongs_to :user
  has_many :account_transactions, dependent: :destroy

  def deposit!(amount:)
    !!(AccountTransaction.create!(operation_type: AccountTransaction::TYPES['DEPOSIT'],
                               amount: amount, account: self))
  end

  def withdraw!(amount:)
    !!(AccountTransaction.create!(operation_type: AccountTransaction::TYPES['WITHDRAW'],
                               amount: amount, account: self))
  end

  def balance
    deposit_amount = AccountTransaction.deposit_by_account(self).sum(&:amount)
    withdraw_amount = AccountTransaction.withdraw_by_account(self).sum(&:amount)

    (deposit_amount - withdraw_amount)
  end
end
