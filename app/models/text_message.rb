class TextMessage

  def initialize(to)
    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
    @to = to
    @from = COMPANY_SMS_NUMBER
    @account = client.account
  end

  def invitation(event_name,url)
    template = "Your invitation to \"%s\": #{url}"
    available_characters = 140 - template.length - 1
    @body = template % textify(event_name, available_characters)
    self
  end

  def deliver
    @account.sms.messages.create({from: @from, to: @to, body: @body})
  end

  private

    def textify(text, max_length)
      text.length > max_length ? "#{ text[0, max_length]}..." : text
    end

end