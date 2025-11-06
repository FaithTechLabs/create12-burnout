class SurveyMailer < ApplicationMailer
  def survey_notification
    survey = params[:survey]
    mail(to: survey.user.email, subject: "Please complete your survey")
  end
end
