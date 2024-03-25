class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :user
  has_one :feedback, dependent: :destroy

  validates :start_date, :end_date, presence: true
  validates :kilometers, presence: true
  validates :kilometers, numericality: { greater_than: 0 }, if: :kilometers_changed? && :persisted?

  before_update :calculate_kilometers_done
  accepts_nested_attributes_for :feedback

  private

  def calculate_kilometers_done
    last_reservation = car.reservations.where(done: true).order(updated_at: :desc).limit(1).first
    last_known_kilometers = last_reservation ? last_reservation.kilometers : car.kilometers
    self.kilometers_done = (kilometers - last_known_kilometers)
  end
end
