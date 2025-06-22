class ActivitiesController < ApplicationController
  def index
    @schedules= Schedule.all
  end
end
