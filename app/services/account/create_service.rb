class Account::CreateService
  attr_accessor :current_user

  def initialize(params = {}, current_user)
    @current_user = current_user
    @params = params
  end

  def execute!
    account = Account.new(user: current_user)
    account.deposit!(amount: @params[:amount])
    account.save!
    account
  end
end