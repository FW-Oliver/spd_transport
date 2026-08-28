class TransportRequest < ApplicationRecord

  broadcasts_to :location,
    target: "transport-requests",
    partial: "locations/transport_requests"
    after_create_commit :broadcast_new_request
    after_update_commit :broadcast_status_changes

  has_many :transport_activities, dependent: :destroy

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
  
  private

  def broadcast_new_request
    broadcast_to_transporters(sound: "announcement")
  end

  def broadcast_to_transporters(sound: nil)
    requests = organization.transport_requests
                            .where(status: %w[requested accepted in_transit])
                            .includes(:location)
                            .order(created_at: :asc)

    broadcast_replace_to(
      "transport_requests_#{organization_id}",
      target: "transporter-requests",
      partial: "transporter/requests/requests",
      locals: { requests: requests },
      attributes: sound ? { "data-sound": sound } : {}
    )
  end

  def broadcast_viewer_refresh
    Turbo::StreamsChannel.broadcast_update_to(
      location,
      target: "viewer-refresh",
      html: ""
    )
  end

  def broadcast_status_changes
    broadcast_viewer_refresh

    if saved_change_to_status? && status == "cancelled"
      broadcast_to_transporters(sound: "cancelled")
    else
      broadcast_to_transporters
    end
  end
end
