class Star < ApplicationRecord
  has_many :planets, dependent: :restrict_with_error

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :spectral_class, presence: true, format: { with: /\A[A-Za-z0-9]+\z/, message: "only allows letters and numbers" }
  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :mass, presence: true, numericality: { greater_than: 0 }
  validates :color, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end
