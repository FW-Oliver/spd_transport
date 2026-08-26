class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :organization, optional: true

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  has_many :transport_activities, dependent: :restrict_with_error

  enum :role, {
    admin: "admin",
    transporter: "transporter",
    viewer: "viewer",
    nurse: "nurse"
  }, default: :nurse
end
