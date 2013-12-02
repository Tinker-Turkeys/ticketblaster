class TextMessageInvitationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, event_id)

    if event = Event.find(event_id)
        TextMessage.new(phone_number).invitation(event.title, 
          new_event_registration_url(event)).deliver
    end

  end

end