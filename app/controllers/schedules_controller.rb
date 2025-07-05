class SchedulesController < ApplicationController
  def index
    @schedules = Location.find(params[:location_id]).schedules
  end

  def show
    @schedules = Schedule.find(params[:schedulable_id])
  end

  def new
    @location = Location.find(params[:location_id])
    @schedule = @location.schedules.new
    @animals = @location.animals
    @crops = @location.crops
    @animal_activities = Activity.where(category: 'animal')
    @crop_activities = Activity.where(category: 'crop')
  end

  def create
    @location = Location.find(params[:location_id])
    @schedule = Schedule.new(schedule_params)
    @animals = @location.animals
    @crops = @location.crops
    @animal_activities = Activity.where(category: 'animal')
    @crop_activities = Activity.where(category: 'crop')
    @schedule.location = @location
    if @schedule.save
      redirect_to location_schedules_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @schedule = Schedule.find(params[:schedulable_id])

  end

  def update
    # @schedule Schedule.find(params[:schedulable_id])

  end

  def destroy
    # Schedule.find(params[:schedulable_id])
    # @schedule.destroy {turbo_method, "delete"},
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_date, :end_date, :schedulable_type, :activity_id, :schedulable_id)
  end
end
