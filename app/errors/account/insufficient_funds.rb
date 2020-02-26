  class Account::InsufficientFunds < StandardError
    def initialize
      message = I18n.t('respond.with.insufficient_balance')
      super(message)
    end
  end
