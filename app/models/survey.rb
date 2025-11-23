class Survey < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  before_create :set_random_hash_id

  NOTIFICATION_WINDOW = 24.hours

  scope :unanswered, -> {
    where(answered_at: nil)
  }

  scope :to_notify, -> {
    unanswered.where("last_notified_at IS NULL OR last_notified_at < ?", NOTIFICATION_WINDOW.ago)
  }

  def completed?
    answered_at.present?
  end

  private

  def set_random_hash_id
    self.hash_id = SecureRandom.hex(10)
  end
end
