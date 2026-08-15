class TransportRequest < ApplicationRecord
  belongs_to :organization
  belongs_to :location

  belongs_to :accepted_by,
             class_name: "User",
             optional: true

  belongs_to :in_transit_by,
           class_name: "User",
           optional: true

  belongs_to :arrived_by,
             class_name: "User",
             optional: true

  belongs_to :completed_by,
             class_name: "User",
             optional: true

  belongs_to :cancelled_by,
             class_name: "User",
             optional: true

  STATUSES = %w[
    requested
    accepted
    in_transit
    completed
    cancelled
  ].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :requested_by_name, presence: true
  validates :requested_at, presence: true

  scope :active, -> {
    where(status: %w[requested accepted in_transit])
  }

  def cancellable?
    status == "requested"
  end
end