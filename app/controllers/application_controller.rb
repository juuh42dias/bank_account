class ApplicationController < ActionController::API

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header # || header.match(/\ABearer\s+(.+)\z/)[1]

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue JWT::DecodeError
      respond_with_failure('respond.with.unauthorized', 401)
    rescue ActiveRecord::RecordNotFound
      respond_with_failure('respond.with.not_found', 401)
    end
  end

  protected

  def respond_with_failure(message, status)
    render json: {
      error: {
        message: I18n.t(message),
        status: status
      }
    }, status: status
  end

  def respond_with_success(object, message, status)
    render json: {
      object: object,
      message: I18n.t(message),
      status: status
    }, status: status
  end
end

