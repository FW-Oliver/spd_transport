class CreateTransporterActions < ActiveRecord::Migration[8.1]
  def change
    create_table :transporter_actions do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.boolean :requires_photo, null: false, default: false
      t.boolean :active, null: false, default: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
