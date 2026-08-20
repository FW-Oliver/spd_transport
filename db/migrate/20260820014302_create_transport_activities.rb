class CreateTransportActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :transport_activities do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :transport_request, null: false, foreign_key: true
      t.references :transporter_action, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.datetime :performed_at, null: false
      t.timestamps
    end
  end
end