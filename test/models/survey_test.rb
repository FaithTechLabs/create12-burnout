require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test ".unanswered returns only unanswered surveys" do
    answered_survey = surveys(:answered)
    assert answered_survey.answered_at.present?

    unanswered_survey = surveys(:unanswered)
    assert unanswered_survey.answered_at.nil?

    unanswered_surveys = Survey.unanswered
    assert_equal [ unanswered_survey ], unanswered_surveys
  end

  test ".to_notify with unanswered survey that was notified more than 24 hours ago" do
    freeze_time do
      survey_needing_notification = surveys(:unanswered)
      survey_needing_notification.update!(last_notified_at: (1.day + 1.minute).ago)

      survey_recently_notified = Survey.create!(
      user: survey_needing_notification.user,
      last_notified_at: 1.hour.ago
      )
      assert survey_recently_notified.last_notified_at > 24.hours.ago

      answered_survey = surveys(:answered)
      assert answered_survey.answered_at.present?

      surveys_to_notify = Survey.to_notify
      assert_equal [ survey_needing_notification ], surveys_to_notify
    end
  end

  test ".to_notify with unanswered survey that was never notified" do
    freeze_time do
      survey_needing_notification = surveys(:unanswered)
      assert survey_needing_notification.last_notified_at.nil?

      survey_recently_notified = Survey.create!(
        user: survey_needing_notification.user,
        last_notified_at: 1.hour.ago
      )
      assert survey_recently_notified.last_notified_at > 24.hours.ago

      answered_survey = surveys(:answered)
      assert answered_survey.answered_at.present?

      surveys_to_notify = Survey.to_notify
      assert_equal [ survey_needing_notification ], surveys_to_notify
    end
  end
end
