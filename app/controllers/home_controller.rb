class HomeController < ApplicationController
  def index
  end

  def contact_us
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    company = params[:company]
    message = params[:message]

    ContactMailer.with(
      name: name,
      email: email,
      phone: phone,
      company: company,
      message: message
    ).contact_email.deliver_now

    redirect_to clients_path, notice: "Your message has been sent successfully!"
  end

  def clients
  end

  def jobs
    @jobs = Job.all
  end

  def apply
  end

  def submit_application
    GeneralApplicationMailer.with(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      resume: params[:resume],
      message: params[:message]
    ).apply_email.deliver_now

    redirect_to apply_path, notice: "Thank you for your application. We will be in touch shortly."
  end

  def about
  end
end
