class Survey < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  scope :unanswered, -> {
    left_joins(:answers).where(answers: { id: nil })
  }
end
