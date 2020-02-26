class Api::V1::AccountController < Api::V1::BaseController
  before_action :authorize_request, except: :deposit

  def index
    accounts = Account.where(user: @current_user)
    render json: accounts, status: 200
  end

  def create
    account_service = Account::CreateService.new(account_params, @current_user)
    account = account_service.execute!

    render json: account, status: 201
  end

  def transfer
    transfer_service = Account::TransferService.new(transfer_params, @current_user)
    amount = transfer_service.execute!

    respond_with_success(I18n.t('respond.with.transferred',
                                source: transfer_service.source_id,
                                destination: transfer_service.destination_id,
                                amount: amount), 200)
  end

  def balance
    balance_service = Account::BalanceService.new(balance_params, @current_user)
    balance = balance_service.execute!

    respond_with_success(I18n.t('respond.with.balance', value: balance), 200)
  end

  def deposit
    deposit_service = Account::DepositService.new(deposit_params)
    deposit = deposit_service.execute!

    respond_with_success(I18n.t('respond.with.deposited', amount: deposit), 200)
  end

  private

  def account_params
    params.permit(:amount)
  end

  def transfer_params
    params.permit(:source_account_id, :destination_account_id, :amount)
  end

  def balance_params
    params.permit(:account_id)
  end

  def deposit_params
    params.permit(:account_id, :amount)
  end
end
