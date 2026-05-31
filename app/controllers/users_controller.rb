class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :update, :destroy ]

  # GET /users
  def index
    authorize User
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/:id
  def show
    authorize @user
    render json: @user, status: :ok
  end

  # PATCH/PUT /users/:id
  def update
    authorize @user
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    authorize @user
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Permit specific attributes to be updated by a manager/admin
  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
