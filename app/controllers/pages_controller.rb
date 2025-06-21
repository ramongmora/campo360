class PagesController < ApplicationController
  def home
    @animals = Animal.all
  end

  def dashboard
    @location = Location.first
  end
end
