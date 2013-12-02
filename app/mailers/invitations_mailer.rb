class InvitationsMailer < ActionMailer::Base

  def notification(name, email, event)
    @name  = name
    @email = email
    @event = event

    subject = "You have been invited!"

    mail(to: @email, from: COMPANY_EMAIL, subject: subject)
  end

end
