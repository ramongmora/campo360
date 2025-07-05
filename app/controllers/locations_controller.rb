class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.where(user_id: current_user.id)
  end

  def show
    @markers =
    [{
      lat: @location.latitude,
      lng: @location.longitude
    }]
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully deleted.'
  end

  private

  def set_location
    @location = Location.where(user_id: current_user.id).find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :surface, :latitude, :longitude)
  end
end
