class EmailInvitationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(name, email, event_id)
    if event = Event.find(event_id)
      InvitationsMailer.notification(name, email, event).deliver
    end
  end

end