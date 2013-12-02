class RegistrationsController < ApplicationController

  before_action :set_event
  before_action :set_registration, only: [:show]

  def new
    @registration = @event.registrations.build
    @token = Registration.next_registration_token(@event)
  end

  def create
    @registration = Registration.update_by_token(params[:token], 
      registration_params)

    if @registration.nil?
      @registration = @event.registrations.build(registration_params)
      @token = Registration.next_registration_token(@event)
      flash.now[:notice] = 
        "Sorry, there are no spots available. Please try again in a few minutes"
      render "new"
    elsif @registration.save
      redirect_to event_registration_url(@event, @registration),
        notice: "You have successfully RSVP'd!"
    else
      render "new"
    end
  end

  def show
  end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_registration
      @registration = @event.registrations.find(params[:id])
    end

    def registration_params
      params.require(:registration)
        .permit(:token, :name, :phone_number, :email, 
          custom_fields: custom_field_params(@event.custom_fields))
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
