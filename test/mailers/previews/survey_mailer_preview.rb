# Preview all emails at http://localhost:3000/rails/mailers/survey_mailer
class SurveyMailerPreview < ActionMailer::Preview
  def survey_notification
    user = User.new(email: "bob.smith@example.com", first_name: "Bob", last_name: "Smith")
    survey = Survey.new(user: user)
    SurveyMailer.with(survey: survey).survey_notification
  end
end
