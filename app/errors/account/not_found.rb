class Account::NotFound < StandardError
  attr_accessor :account_number

  def initialize(account_number)
    message = 'respond.with.account_not_found'
    message = I18n.t(message, account_number: account_number)
    super(message)
  end
end
