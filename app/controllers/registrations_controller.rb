class RegistrationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build
  end

  def create
  end

  def show
  end
end
