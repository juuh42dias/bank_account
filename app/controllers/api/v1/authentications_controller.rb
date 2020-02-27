class Api::V1::AuthenticationsController < Api::V1::BaseController

  # POST /auth/login
  def login
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      expire_token = 2.hours.from_now
      token = JsonWebToken.encode(user_id: user.id, exp: expire_token.to_i)

      render json: { token: token, expire: expire_token.strftime('%d/%m/%Y %H:%M'),
                     name: user.name }, status: :ok
    else
      respond_with_failure(I18n.t('respond.with.unauthorized'), 401)
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
