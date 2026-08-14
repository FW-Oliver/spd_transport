class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.boolean :active
      t.string :qr_token

      t.timestamps
    end
  end
end
