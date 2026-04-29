class JogEntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @jog_entries = current_user.jog_entries.order(date: :desc)
    render json: @jog_entries, status: :ok
  end

  def create
    @jog_entry = current_user.jog_entries.build(jog_entry_params)

    if @jog_entry.save
      render json: @jog_entry, status: :created
    else
      render json: { errors: @jog_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @jog_entry = JogEntry.find(params[:id])

    # Check if the current user is allowed to delete this specific record
    authorize @jog_entry

    @jog_entry.destroy
    head :no_content
  end

  private

  def jog_entry_params
    params.require(:jog_entry).permit(:date, :distance, :time)
  end
end
