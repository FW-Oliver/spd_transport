class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  belongs_to :organization, optional: true

  enum :role, {
    admin: "admin",
    transporter: "transporter",
    viewer: "viewer",
    nurse: "nurse"
  }, default: :nurse
end