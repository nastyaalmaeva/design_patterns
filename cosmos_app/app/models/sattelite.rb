class Sattelite < ApplicationRecord
  belongs_to :planet

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :planet, presence: true
  validates :sattelite_type, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :mass, presence: true, numericality: { greater_than: 0 }
  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :form, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end
