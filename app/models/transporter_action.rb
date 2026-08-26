class TransporterAction < ApplicationRecord
  belongs_to :organization

  has_many :transport_activities, dependent: :restrict_with_error
end
