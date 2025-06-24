class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_location

  private

  def current_location
    return nil unless user_signed_in?
    current_user.locations.first
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
