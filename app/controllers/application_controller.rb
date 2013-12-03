class ApplicationController < ActionController::Base

  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :signed_in_user

  def signed_in_user
    unless signed_in?
      save_current_url
      redirect_to root_url #TODO change to special login page
    end
  end

end
