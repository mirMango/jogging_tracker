class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      # Cont creat cu succes
      render json: {
        status: { code: 200, message: "Signed up successfully." },
        data: current_user
      }, status: :ok
    else
      # Eroare la creare (ex: email deja folosit, parola prea scurta)
      render json: {
        status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
1
