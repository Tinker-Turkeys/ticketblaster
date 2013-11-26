class RegistrationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build
  end

  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(params[:registration])
    render "new"
  end

  def show
  end
end
