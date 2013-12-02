class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.add_custom_fields(event_params[:custom_fields])

    if params[:commit] == 'add_custom_field'
      @event.custom_fields << CustomField.new
      render :new
    elsif @event.save
      redirect_to @event, notice: "Successfully created event"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.add_custom_fields(event_params[:custom_fields])
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated"
    else
      flash.now[:error] = "Event not updated"
      render "edit"
    end
  end

  def destroy
    if @event.expired? || @event.registrations.any?
      redirect_to @event, alert: "You cannot cancel this event"
    else
      @event.destroy
      redirect_to events_path, notice: "Your event has been cancelled"
    end
  end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :occurring_on, 
        :location, :image_url, :slots, :published, :public, 
        :custom_fields => [:label, :type, :name, :value, :options, :ignore])
    end

end
