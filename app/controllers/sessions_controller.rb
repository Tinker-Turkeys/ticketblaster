class SessionsController < ApplicationController

  skip_before_action :signed_in_user, only: [:create, :destroy]

  def create
    @user = User.where(provider: auth_hash.provider, uid: auth_hash.uid)
      .first_or_initialize.tap do |user|
        user.name = auth_hash.info.name
        if user.new_record? && auth_hash.info.email
          user.email = auth_hash.info.email
        end
      end

    if @user.save
      sign_in(@user)
      redirect_to requested_url(root_url)
    else
      redirect_to root_url, notice: 'Unable to log in.'
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: 'You are now logged out.'
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end

end