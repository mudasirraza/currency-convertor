class Rate < ApplicationRecord
  validates :from_currency, :to_currency, :rate, :date, presence: true
  validates :from_currency, :to_currency, length: { is: 3 }, format: { with: /[A-Z]/ }
  validates :rate, numericality: { only_float: true }
  validate :valid_date

  scope :latest, -> { where(date: Rate.select('MAX(date)')) }
  scope :date_after, ->(date) { where('date > ?', date) if date.present? }
  scope :with_to_currency, ->(to_currency) { where('to_currency = ?', to_currency) if to_currency.present? }
  scope :with_from_currency, ->(from_currency) { where('from_currency = ?', from_currency) if from_currency.present? }

  private

  def valid_date
    errors.add(:date, 'must be a valid date') unless date.is_a?(Date)
  end
end
