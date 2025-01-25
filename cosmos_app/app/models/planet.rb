class Planet < ApplicationRecord
  belongs_to :star
  has_many :sattelites, dependent: :restrict_with_error

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :star, presence: true
  validates :planet_type, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :mass, presence: true, numericality: { greater_than: 0 }
  validates :temperature, presence: true, numericality: { greater_than: 0 }
end
