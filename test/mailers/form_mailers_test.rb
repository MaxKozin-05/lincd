require "test_helper"

class FormMailersTest < ActiveSupport::TestCase
  FakeUpload = Struct.new(:original_filename, :contents) do
    def read
      contents
    end
  end

  setup do
    @previous_contact_email = ENV["LINCD_CONTACT_EMAIL"]
    @previous_mailer_from = ENV["MAILER_FROM"]

    ENV["LINCD_CONTACT_EMAIL"] = "linc@example.com"
    ENV["MAILER_FROM"] = "linc@example.com"
  end

  teardown do
    ENV["LINCD_CONTACT_EMAIL"] = @previous_contact_email
    ENV["MAILER_FROM"] = @previous_mailer_from
  end

  test "client enquiry uses linc mailbox and reply_to applicant" do
    email = ContactMailer.with(
      name: "Jane Doe",
      email: "jane@example.com",
      phone: "0400000000",
      company: "Acme",
      message: "Need staffing help"
    ).contact_email

    assert_equal [ "linc@example.com" ], email.to
    assert_equal [ "linc@example.com" ], email.from
    assert_equal [ "jane@example.com" ], email.reply_to
    assert_equal "Client Enquiry from Jane Doe", email.subject
  end

  test "general application uses linc mailbox and attaches resume" do
    email = GeneralApplicationMailer.with(
      name: "Jane Doe",
      email: "jane@example.com",
      phone: "0400000000",
      resume: FakeUpload.new("resume.pdf", "resume-body"),
      message: "Interested in future roles"
    ).apply_email

    assert_equal [ "linc@example.com" ], email.to
    assert_equal [ "linc@example.com" ], email.from
    assert_equal [ "jane@example.com" ], email.reply_to
    assert_equal "General Candidate Application from Jane Doe", email.subject
    assert_equal [ "resume.pdf" ], email.attachments.map(&:filename)
  end

  test "job application uses linc mailbox and job-specific subject" do
    job = Job.create!(title: "Recruitment Consultant")

    email = JobApplicationMailer.with(
      job: job,
      name: "Jane Doe",
      phone: "0400000000",
      email: "jane@example.com",
      resume: FakeUpload.new("resume.pdf", "resume-body"),
      message: "I would like to apply."
    ).apply_email

    assert_equal [ "linc@example.com" ], email.to
    assert_equal [ "linc@example.com" ], email.from
    assert_equal [ "jane@example.com" ], email.reply_to
    assert_equal "Job Application for Recruitment Consultant", email.subject
    assert_equal [ "resume.pdf" ], email.attachments.map(&:filename)
  end
end
