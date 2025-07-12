class PagesController < ApplicationController
  # Permitir acceso público a la landing y soporte
  skip_before_action :authenticate_user!, only: [:home, :support]

  def home
    @location = Location.first
    @animals = Animal.all
  end

  def dashboard
    @locations = current_user.locations

    # Guardar nueva selección si viene en params
    if params[:location_id].present?
      session[:selected_location_id] = params[:location_id]
    end

    # Usar la selección guardada, luego el principal, luego el primero
    @location =
      @locations.find_by(id: session[:selected_location_id]) ||
      current_user.main_location ||
      @locations.first
  end

  def actividad
    # Lógica opcional para vista de actividad
  end

  def ajustes
    # Lógica opcional para ajustes de usuario
  end
  def support
    # Soporte público
  end
end
