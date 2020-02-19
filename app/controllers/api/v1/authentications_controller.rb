class Api::V1::AuthenticationsController < ApplicationController

  # POST /auth/login
  def login
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      expire_token = 24.hours.from_now
      token = JsonWebToken.encode(user_id: user.id, expire: expire_token)

      render json: { token: token, expire: expire_token.strftime("%d/%m/%Y %H:%M"),
                      name: user.name }, status: :ok
    else
      respond_with_failure('respond.with.unauthorized', 401)
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
