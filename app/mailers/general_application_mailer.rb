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
      to: ENV.fetch("LINCD_CONTACT_EMAIL", "contact@lincd.com"),
      from: @email,
      subject: "General Candidate Application from #{@name}"
    )
  end
end
