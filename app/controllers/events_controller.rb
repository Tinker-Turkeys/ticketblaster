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
    if @event.save
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
        :location, :image_url, :slots, :published, :public)
    end

end
