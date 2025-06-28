class SchedulesController < ApplicationController
  def index
    @schedules = Location.find(params[:location_id]).schedules
  end

  def show
    @schedules = Schedule.find(params[:schedulable_id])
  end

  def new
    @schedule = Schedule.new
    @location = Location.find(params[:location_id])
  end

  def create
    Schedule.create(schedule_params)
  end

  def edit
    # @schedulable = Schedule.find(params[:schedulable_id])

  end

  def update
    # @schdedulable Schedule.find(params[:schedulable_id])

  end

  def destroy
    # Schedule.find(params[:schedulable_id])
    # @schdulable.destroy {turbo_method, "delete"},
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_date, :end_date, :schedulable_type, :activity)
  end
end
