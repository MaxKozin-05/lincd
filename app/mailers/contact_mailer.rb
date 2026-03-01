class ContactMailer < ApplicationMailer
  def contact_email
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]
    @company = params[:company]
    @message = params[:message]

    mail(
      to: ENV.fetch("LINCD_CONTACT_EMAIL", "contact@lincd.com"),
      from: @email,
      subject: "Client Enquiry from #{@name}"
    )
  end
end
