class PagesController < ApplicationController
  def home
    @location = Location.first
    @animals = Animal.all
  end

  def dashboard
    @location = Location.first
  end

  def actividad
    # Puedes agregar lógica si lo necesitas
  end

  def ajustes
    # Puedes agregar lógica si lo necesitas
  end
end
