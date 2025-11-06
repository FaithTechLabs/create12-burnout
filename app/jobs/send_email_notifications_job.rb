class SendEmailNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    unanswered_surveys = Survey.unanswered
    unanswered_surveys.each do |survey|
      SurveyMailer.with(survey: survey).survey_notification.deliver_later
    end
  end
end
