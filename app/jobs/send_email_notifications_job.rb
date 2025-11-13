class SendEmailNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "SendEmailNotificationsJob started at #{Time.current}"

    Survey.to_notify.each do |survey|
      SurveyMailer.with(survey: survey).survey_notification.deliver_later
      survey.update!(last_notified_at: Time.current)
    end

    Rails.logger.info "SendEmailNotificationsJob finished at #{Time.current}"
  end
end
