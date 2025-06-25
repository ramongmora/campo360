class ApplicationController < ActionController::Base
  # 🔐 Protege por defecto, pero puedes omitirlo en controladores públicos
  before_action :authenticate_user!

  # 👇 Para usar current_location en vistas o controladores
  helper_method :current_location

  # 🔒 Redirecciona después de cerrar sesión
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # ✅ Redirecciona después de iniciar sesión
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  private

  def current_location
    return nil unless user_signed_in?
    current_user.locations.first
  end
end
