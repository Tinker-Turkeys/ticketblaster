class RegistrationsController < ApplicationController

  before_action :set_event
  before_action :set_registration, only: [:show]

  def new
    @registration = @event.registrations.build
  end

  def create
    @registration = @event.registrations.build(registration_params)
    if @registration.save
      redirect_to event_registration_url(@event, @registration),
        notice: "You have successfully RSVP'd!"
    else
      render "new"
    end
  end

  def show
    render text: @registration.inspect
  end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_registration
      @registration = @event.registrations.find(params[:event_id])
    end

    def registration_params
      params.require(:registration)
        .permit(custom_fields: custom_field_params(@event.custom_fields))
    end

    def custom_field_params(custom_fields)
      custom_fields.map do |custom_field|
        if custom_field.multi_value?
          { custom_field.name => [] }
        else
          custom_field.name
        end
      end
    end
end
