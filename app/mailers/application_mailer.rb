class ApplicationMailer < ActionMailer::Base
  default from: -> { default_from_address }
  layout "mailer"

  private

  def contact_recipient
    ENV["LINCD_CONTACT_EMAIL"].presence || ENV["MAILER_FROM"].presence || "contact@lincd.com"
  end

  def default_from_address
    ENV["MAILER_FROM"].presence || contact_recipient
  end
end
