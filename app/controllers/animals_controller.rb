class AnimalsController < ApplicationController
  before_action :set_location, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @animals = @location.animals.where("alias ILIKE ?", "%#{params[:query]}%")
    else
      @animals = @location.animals
    end
  end

  def show
    # Ya tienes acceso a @location y @animal
  end

  def new
    @location = Location.find(params[:location_id])
    @animal = @location.animals.new
  end

  def create
    @location = Location.find(params[:location_id])
    @animal = @location.animals.new(animal_params)

    if @animal.save
      redirect_to location_animals_path(@location), notice: "Animal creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @animal.update(animal_params)
      redirect_to location_animals_path(@location), notice: "Animal actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @animal.destroy
    redirect_to location_animals_path(@location), notice: "Animal eliminado."
  end

  private

  def set_location
    @location = Animal.find(params[:id]).location if params[:id] && !params[:location_id]
    @location ||= Location.find(params[:location_id])
  end

  def set_animal
    @animal = Animal.find(params[:id])
    @location = @animal.location
  end

  def animal_params
    params.require(:animal).permit(:breed_id, :alias, :birth_date, :gender, :follow, :photo)
  end
end
