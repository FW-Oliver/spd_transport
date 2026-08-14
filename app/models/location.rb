require "securerandom"

class Location < ApplicationRecord
  belongs_to :organization

  has_many :transport_requests, dependent: :restrict_with_error

  before_validation :generate_qr_token, on: :create

  validates :name, presence: true
  validates :qr_token, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }

  private

  def generate_qr_token
    self.qr_token ||= SecureRandom.urlsafe_base64(16)
  end
end