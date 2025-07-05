class CropsController < ApplicationController
  before_action :set_location
  before_action :set_crop, only: [:show, :edit, :update, :destroy]

  def index
    @crops = @location.crops
  end

  def show
  end

  def new
    @crop = @location.crops.new
  end

  def create
    @crop = @location.crops.new(crop_params)
    if @crop.save
      redirect_to [@location, @crop], notice: "Crop created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @crop.update(crop_params)
      redirect_to [@location, @crop], notice: 'Crop was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @crop.destroy
    redirect_to location_crops_path(@location), notice: 'Crop was successfully destroyed.'
  end

  private

    def set_location
      @location = Location.find(params[:location_id])
    end

    def set_crop
      @crop = @location.crops.find(params[:id])
    end

    def crop_params
      params.require(:crop).permit(:kind, :harvest_date, :sowing_date, :surface, :follow, :photo)
    end

end
