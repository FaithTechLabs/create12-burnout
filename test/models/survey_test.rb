require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test ".unanswered returns only surveys without answers" do
    answered_survey = surveys(:answered)
    assert answered_survey.answers.any?

    unanswered_survey = surveys(:unanswered)
    assert unanswered_survey.answers.empty?

    unanswered_surveys = Survey.unanswered
    assert_equal [ unanswered_survey ], unanswered_surveys
  end
end
