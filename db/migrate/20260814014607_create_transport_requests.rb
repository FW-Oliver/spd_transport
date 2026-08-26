class CreateTransportRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :transport_requests do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.string :status, null: false, default: "requested"

      t.string :requested_by_name, null: false
      t.datetime :requested_at, null: false

      t.references :accepted_by,
                   foreign_key: { to_table: :users },
                   null: true
      t.datetime :accepted_at

      t.references :arrived_by,
                   foreign_key: { to_table: :users },
                   null: true
      t.datetime :arrived_at

      t.references :completed_by,
                   foreign_key: { to_table: :users },
                   null: true
      t.datetime :completed_at

      t.references :cancelled_by,
                   foreign_key: { to_table: :users },
                   null: true
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
