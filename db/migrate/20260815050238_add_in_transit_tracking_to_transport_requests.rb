class AddInTransitTrackingToTransportRequests < ActiveRecord::Migration[8.1]
  def change
    add_reference :transport_requests,
                  :in_transit_by,
                  null: true,
                  foreign_key: { to_table: :users }

    add_column :transport_requests, :in_transit_at, :datetime
  end
end