class JobApplicationMailer < ApplicationMailer
  def apply_email
    @job = params[:job]
    @name = params[:name]
    @phone = params[:phone]
    @email = params[:email]
    @message = params[:message]

    attachments[params[:resume].original_filename] = params[:resume].read if params[:resume].present?

    mail(
      to: contact_recipient,
      reply_to: @email.presence,
      subject: "Job Application for #{@job.title}"
    )
  end
end
