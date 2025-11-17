class SurveyMailer < ApplicationMailer
  def survey_notification
    survey = params[:survey]
    @hash_id = survey.hash_id
    mail(to: survey.user.email, subject: "Please complete your survey")
  end
end
