class JogEntry < ApplicationRecord
  # Legătura cu User-ul (generată automat)
  belongs_to :user

  validates :date, :distance, :time, presence: true
  validates :distance, numericality: { greater_than: 0 }
  validates :time, numericality: { greater_than: 0 } # Timpul va fi în minute

  before_save :calculate_average_speed

  private

  def calculate_average_speed
    return unless distance.present? && time.present? && time > 0
    hours = time.to_f / 60.0
    self.average_speed = (distance / hours).round(2)
  end
end
