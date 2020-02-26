class Account::DepositService
  include ActionView::Helpers::NumberHelper

  def initialize(params = {})
    @params = params
  end

  def execute!
    account.deposit!(amount: @params[:amount])
    account.save!
    number_to_currency(@params[:amount])
  end

  private

  def account
    unless Account.exists?(@params[:account_id])
      raise Account::NotFound, @params[:account_id]
    end

    Account.find(@params[:account_id])
  end
end
