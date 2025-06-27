class SchedulesController < ApplicationController
  def index
    @schedules = Location.find(params[:location_id]).schedules
  end

  def show
    @schedules = Schedule.find(params[:schedulable_id])
  end

  def new
    # @schdedule = Schedule.new(schedule_params)
  end

  def create
    # @schedule.create(schedule_params)

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
# def schedule_params


end
