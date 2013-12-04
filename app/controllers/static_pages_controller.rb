class StaticPagesController < ApplicationController

  skip_before_action :signed_in_user, only: [:index]

  layout 'homepage'

  def index
    @public_events = Event.where(public: true)
  end

end
