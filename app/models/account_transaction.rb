class AccountTransaction < ApplicationRecord
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :account

  TYPES = { 'WITHDRAW' => I18n.t('withdraw'),
            'DEPOSIT' => I18n.t('deposit') }.freeze

  scope :deposit, -> { where(operation_type: AccountTransaction::TYPES['DEPOSIT']) }
  scope :withdraw, -> { where(operation_type: AccountTransaction::TYPES['WITHDRAW']) }

  scope :deposit_by_account, ->(account) { where(account: account, operation_type: AccountTransaction::TYPES['DEPOSIT']) }
  scope :withdraw_by_account, ->(account) { where(account: account, operation_type: AccountTransaction::TYPES['WITHDRAW']) }
end
