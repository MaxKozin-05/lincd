class ContactMailer < ApplicationMailer
  def contact_email
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]
    @company = params[:company]
    @message = params[:message]

    mail(
      to: contact_recipient,
      reply_to: @email.presence,
      subject: "Client Enquiry from #{@name}"
    )
  end
end
