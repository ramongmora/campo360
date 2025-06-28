class AnimalsController < ApplicationController
  before_action :set_location, only: [:index]
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @animals = @location.animals.where("alias ILIKE ?", "%#{params[:query]}%")
    else
      @animals = @location.animals
    end
  end

  def show
    # respond_to do |format|
    #   format.html
    #   format.turbo_stream { render partial: "show", locals: { animal: @animal, location: @location } }
    # end
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
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
    @location = Location.find(params[:location_id])
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:breed, :alias, :birth_date, :gender, :follow, :animal_group_id)
  end
end
