class Api::V1::BaseController < ApplicationController

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue JWT::DecodeError
      respond_with_failure(I18n.t('respond.with.unauthorized'), 401)
    end
  end
end