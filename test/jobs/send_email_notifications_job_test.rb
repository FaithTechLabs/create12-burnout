require "test_helper"

class SendEmailNotificationsJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test "sends emails only for unanswered surveys that haven't been notified in the last 24 hours" do
    notify_surveys = Survey.to_notify.to_a
    assert_operator Survey.all.count, :>, notify_surveys.count

    emails = capture_emails do
      SendEmailNotificationsJob.perform_now
    end

    assert_equal notify_surveys.count, emails.size
    assert_equal notify_surveys.first.user.email, emails.first.to.first
  end

  test "updates last_notified_at for surveys where notifications are sent" do
    freeze_time do
      survey_to_notify = Survey.to_notify.first
      assert_nil survey_to_notify.last_notified_at

      SendEmailNotificationsJob.perform_now
      survey_to_notify.reload

      assert_equal Time.current, survey_to_notify.last_notified_at
    end
  end
end
