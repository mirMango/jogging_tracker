class Users::SessionsController < Devise::SessionsController
  # Îi spunem să comunice doar prin JSON
  respond_to :json

  private

  # Ce se întâmplă când login-ul are succes
  def respond_with(current_user, _opts = {})
    render json: {
      status: { code: 200, message: "Logged in successfully." },
      data: current_user
    }, status: :ok
  end

  # Ce se întâmplă când dăm logout
  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
