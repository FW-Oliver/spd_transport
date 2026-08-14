class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :transport_requests, dependent: :destroy

  validates :name, presence: true
end