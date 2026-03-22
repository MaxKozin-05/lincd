class GeneralApplicationMailer < ApplicationMailer
  def apply_email
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]
    @message = params[:message]

    if params[:resume].present?
      attachments[params[:resume].original_filename] = params[:resume].read
    end

    mail(
      to: contact_recipient,
      reply_to: @email.presence,
      subject: "General Candidate Application from #{@name}"
    )
  end
end
