class Survey < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  NOTIFICATION_WINDOW = 24.hours

  scope :unanswered, -> {
    where(answered_at: nil)
  }

  scope :to_notify, -> {
    unanswered.where("last_notified_at IS NULL OR last_notified_at < ?", NOTIFICATION_WINDOW.ago)
  }
end
