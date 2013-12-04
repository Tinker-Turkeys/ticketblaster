class StaticPagesController < ApplicationController

  skip_before_action :signed_in_user, only: [:index]

  layout 'homepage'

  def index
    @open_events = Event.open
  end

end
