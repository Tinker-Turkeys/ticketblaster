class EventsController < ApplicationController
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
      redirect_to @event, notice: "Successfully created event!"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

    private

    def event_params
      params.require(:event).permit(:title, :description, :occurring_on, 
        :location, :image_url, :slots, :published, :public, 
        :custom_fields => [:label, :type, :name, :value, :options])
    end

end
