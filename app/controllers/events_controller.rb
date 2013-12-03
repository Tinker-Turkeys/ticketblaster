class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @invitee = @event.invitees.build
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.add_custom_fields(custom_fields_params)

    if params[:commit] == 'add_custom_field'
      @event.custom_fields << CustomField.new
      render :new
    elsif @event.save
    raise
      redirect_to @event, notice: "Successfully created event"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.add_custom_fields(custom_fields_params)

    if params[:commit] == 'add_custom_field'
      @event.custom_fields << CustomField.new
      render :edit
    elsif @event.update(event_params)
      redirect_to @event, notice: "Event updated"
    else
      flash.now[:error] = "Event not updated"
      render "edit"
    end
  end

  def destroy
    if @event.expired? || @event.registrations.any?
      redirect_to @event, notice: "You cannot cancel this event"
    else
      @event.cancel!
      redirect_to events_path, notice: "Your event has been cancelled"
    end
  end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :occurring_on, 
        :location, :image_url, :slots, :published, :public) 
    end

    def custom_fields_params
      p = params.permit(:custom_fields => [:label, :type, :name, :value, :options, :ignore])
      p[:custom_fields]
    end
end
