require 'bigdecimal/util'

class Account::TransferService
  include ActionView::Helpers::NumberHelper

  attr_accessor :source_id, :destination_id, :current_user, :amount

  def initialize(params = {}, current_user)
    @current_user = current_user
    @source_id = params[:source_account_id]
    @destination_id = params[:destination_account_id]
    @amount = params[:amount]
  end

  def execute!
    ActiveRecord::Base.transaction do
      ensures_valid_params!

      source_account.withdraw!(amount: amount)
      destination_account.deposit!(amount: amount)
    end

    number_to_currency(amount)
  end

  private

  def ensures_valid_params!
    unless current_user.accounts.exists?(source_id)
      raise Account::NotFound, source_id
    end

    unless Account.exists?(destination_id)
      raise Account::NotFound, destination_id
    end

    raise Account::InsufficientFunds unless sufficient_funds?
  end

  def source_account
    current_user.accounts.find(source_id)
  end

  def destination_account
    Account.find(destination_id)
  end

  def sufficient_funds?
    source_account.balance.to_d >= amount.to_d
  end
end
