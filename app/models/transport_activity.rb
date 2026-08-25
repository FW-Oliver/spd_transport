class TransportActivity < ApplicationRecord
  belongs_to :organization
  belongs_to :transport_request, optional: true
  belongs_to :transporter_action
  belongs_to :user
  belongs_to :location

  has_one_attached :evidence_photo
  has_one_attached :evidence_thumbnail

  validate :photo_required_for_action

  private

  def photo_required_for_action
    return unless transporter_action&.requires_photo?
    return if evidence_photo.attached?

    errors.add(:photo, "is required for this action")
  end
end