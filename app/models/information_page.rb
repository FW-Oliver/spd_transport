class InformationPage < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true
  validates :slug, uniqueness: { scope: :organization_id }
end
