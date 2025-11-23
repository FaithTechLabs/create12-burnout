# Preview all emails at http://localhost:3000/rails/mailers/survey_mailer
class SurveyMailerPreview < ActionMailer::Preview
  def survey_notification
    user = User.new(email: "bob.smith@example.com", first_name: "Bob", last_name: "Smith")
    survey = Survey.new(user: user)
    survey.hash_id = "a0b1c2d3e4f5g6h7i8j9"
    SurveyMailer.with(survey: survey).survey_notification
  end

  def survey_complete
    user = User.new(email: "bob.smith@example.com", first_name: "Bob", last_name: "Smith")
    survey = Survey.new(user: user)
    survey.answers.build(question_id: 1, answer: 1)
    survey.answers.build(question_id: 2, answer: 3)
    survey.answers.build(question_id: 3, answer: 2)
    survey.last_notified_at = Time.now
    survey.save!
    SurveyMailer.with(survey: survey).survey_complete
  end
end
