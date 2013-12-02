class Events::InviteesController < ApplicationController

  before_action :set_event
  before_action :set_invitee, only: [:edit, :update, :destroy]

  def create
    @invitee = @event.invitees.build(invitee_params)
    if @invitee.save
      redirect_to @event, 
        notice: "#{@invitee.name} was added to the guest list."
    else
      render 'events/show'
    end
  end

  def edit
    render 'events/show'
  end

  def update
    if @invitee.update(invitee_params)
      redirect_to @event, 
        notice: "#{@invitee.name}'s details have been changed successfully."
    else
      render 'events/edit'
    end
  end

  def destroy
    if @invitee.destroy
      flash[:notice] = "#{@invitee.name} removed from guest list."
    else
      flash[:error] = "#{@invitee.name} was not removed from guest list."
    end
    redirect_to @event
  end

  private 

    def invitee_params
      params.require(:invitee).permit(:name, :email, :phone_number)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_invitee
      @invitee = @event.invitees.find(params[:id])
    end

end