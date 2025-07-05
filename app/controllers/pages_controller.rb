class PagesController < ApplicationController
  # Permitir acceso público a la landing
  skip_before_action :authenticate_user!, only: :home

  def home
    @location = Location.first
    @animals = Animal.all
  end

  def dashboard
    @locations = current_user.locations
    @location = @locations.find_by(id: params[:location_id]) || @locations.first
  end

  def actividad
    # Lógica opcional para vista de actividad
  end

  def ajustes
    # Lógica opcional para ajustes de usuario
  end

  class PagesController < ApplicationController
    def support
    end
  end

end
