class JogEntriesController < ApplicationController
  before_action :authenticate_user!

  # GET /jog_entries
  def index
    @jog_entries = current_user.jog_entries

    if params[:from].present?
      @jog_entries = @jog_entries.where("date >= ?", params[:from])
    end

    if params[:to].present?
      @jog_entries = @jog_entries.where("date <= ?", params[:to])
    end

    @jog_entries = @jog_entries.order(date: :desc)
    render json: @jog_entries, status: :ok
  end

  def report
    @jog_entries = current_user.jog_entries

    weekly_data = @jog_entries.group_by { |entry| entry.date.beginning_of_week }

    report_data = weekly_data.map do |week_start, entries|
      total_distance = entries.sum(&:distance)
      total_time = entries.sum(&:time)

      average_speed = total_time > 0 ? (total_distance / (total_time.to_f / 60)).round(2) : 0

      {
        week_starting: week_start,
        total_distance: total_distance.round(2),
        average_speed: average_speed
      }
    end

    render json: report_data, status: :ok
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
