class ApplicationController < ActionController::API

  rescue_from Account::InsufficientFunds, with: nil do
    respond_with_failure(I18n.t('respond.with.insufficient_balance'), 422)
  end

  rescue_from Account::NotFound, with: nil do |error|
    respond_with_failure(error.message, 404)
  end

  rescue_from ActiveRecord::RecordNotFound, with: nil do
    respond_with_failure(I18n.t('respond.with.not_found'), 404)
  end

  rescue_from ActiveRecord::RecordInvalid, with: nil do |exception|
    respond_with_failure(exception.message, 422)
  end

  protected

  def respond_with_failure(message, status)
    render json: {
      error: {
        message: message,
        status: status
      }
    }, status: status
  end

  def respond_with_success(message, status)
    render json: {
      message: message,
      status: status
    }, status: status
  end
end
