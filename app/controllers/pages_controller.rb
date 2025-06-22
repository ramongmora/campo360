class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @location = Location.first
    @animals = Animal.all
  end

  def dashboard
    @locations = current_user.locations
  end

  def actividad
    # Puedes agregar lógica si lo necesitas
  end

  def ajustes
    # Puedes agregar lógica si lo necesitas
  end
end
