class JobApplicationMailer < ApplicationMailer
  def apply_email
    @job = params[:job]
    @name = params[:name]
    @phone = params[:phone]
    @email = params[:email]
    @message = params[:message]

    attachments[params[:resume].original_filename] = params[:resume].read if params[:resume].present?

    mail(
      to: ENV.fetch("LINCD_CONTACT_EMAIL", "contact@lincd.com"),
      from: @email,
      subject: "Job Application for #{@job.title}"
    )
  end
end
