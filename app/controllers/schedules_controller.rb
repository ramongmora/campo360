class SchedulesController < ApplicationController
  before_action :set_location_and_resources, only: [:new, :edit, :create, :update]

  def index
    @schedules = Location.find(params[:location_id]).schedules
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = @location.schedules.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.location = @location
    if @schedule.save
      redirect_to location_schedules_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    @location = Location.find(params[:location_id])
    if @schedule.update(schedule_params)
      redirect_to dashboard_path, notice: 'Actividad actualizada con éxito.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to location_schedules_path(params[:location_id]), notice: 'Schedule was successfully deleted.'
  end

  private

  def set_location_and_resources
    @location = Location.find(params[:location_id])
    @animals = @location.animals
    @crops = @location.crops
    @animal_activities = Activity.where(category: 'animal')
    @crop_activities = Activity.where(category: 'crop')
  end

  def schedule_params
    params.require(:schedule).permit(:start_date, :end_date, :schedulable_type, :activity_id, :schedulable_id)
  end
end
