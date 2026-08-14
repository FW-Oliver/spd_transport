class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  belongs_to :organization, optional: true

  enum :role, {
    admin: "admin",
    manager: "manager",
    transporter: "transporter",
    nurse: "nurse"
  }, default: :nurse
end