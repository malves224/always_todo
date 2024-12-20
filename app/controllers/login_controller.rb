class LoginController < ApplicationController
  def login
    user = User.find_by_email(params_permit[:email])
    if user&.authenticate(params_permit[:password])
      payload = { id: user.id, email: user.email }
      return render status: :ok, json: { id: user.id, token: JsonWebToken.encode(payload) }
    end
    render status: :unauthorized, json: { errors: [I18n.t('login_controller.errors.invalid_login')] }
  end

  private

  def params_permit
    params.permit(:email, :password)
  end
end
