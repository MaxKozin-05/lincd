class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy apply]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]

  def index
    if params[:search].present?
      @jobs = Job.where("title ILIKE ?", "%#{params[:search]}%")
    else
      @jobs = Job.all
    end
  end

  def show
  end

  def new
    @job = Job.new
  end

  def apply
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    resume = params[:resume]
    message = params[:message]

    JobApplicationMailer.with(
      job: @job,
      name: name,
      phone: phone,
      email: email,
      resume: resume,
      message: message
    ).apply_email.deliver_now

    redirect_to job_path(@job), notice: "Thank you for your application. We will be in touch shortly."
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job, notice: "Job was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: "Job was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url, notice: "Job was successfully destroyed."
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :sub_heading, :salary, :description, :location, :category, :benefits)
  end
end
