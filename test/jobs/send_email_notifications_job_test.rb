require "test_helper"

class SendEmailNotificationsJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test "sends emails only for unanswered surveys" do
    answered_survey = surveys(:answered)
    unanswered_survey = surveys(:unanswered)

    assert answered_survey.answers.any?
    assert unanswered_survey.answers.empty?

    emails = capture_emails do
      SendEmailNotificationsJob.perform_now
    end

    assert_equal 1, emails.size
    assert_equal unanswered_survey.user.email, emails.first.to.first
  end
end
