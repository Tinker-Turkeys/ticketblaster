class RegistrationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build
  end

  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(registration_params)
    render "new"
  end

  def show
  end

  private

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
