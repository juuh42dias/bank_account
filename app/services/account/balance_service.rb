class Account::BalanceService
  include ActionView::Helpers::NumberHelper
  attr_accessor :current_user

  def initialize(params = {}, current_user)
    @current_user = current_user
    @params = params
  end

  def execute!
    number_to_currency(account.balance)
  end

  private

  def account
    if current_user.account_ids.include?(@params[:account_id].to_i)
      return Account.find(@params[:account_id])
    end

    raise Account::NotFound.new(@params[:account_id])
  end
end
