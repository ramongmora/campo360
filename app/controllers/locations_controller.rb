class LocationsController < ApplicationController
  def index
    @locations = Location.find_by(user_id: current_user)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destoy
  end
end
