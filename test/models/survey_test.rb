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

  test "sets hash_id before creation" do
    survey = Survey.new(user: users(:bob))
    assert_nil survey.hash_id

    survey.save!
    assert_not_nil survey.hash_id
    assert_equal 20, survey.hash_id.length
  end

  test "hash_id has unique constraint" do
    survey = Survey.new(user: users(:bob))
    survey.save!

    another_survey = Survey.new(user: users(:bob))
    another_survey.save!

    refute_equal survey.hash_id, another_survey.hash_id
    assert_raises ActiveRecord::RecordNotUnique do
      another_survey.update_column(:hash_id, survey.hash_id)
    end
  end
end
