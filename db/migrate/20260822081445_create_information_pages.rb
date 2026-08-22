class CreateInformationPages < ActiveRecord::Migration[8.1]
  def change
    create_table :information_pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :content, null: false
      t.boolean :published, null: false, default: false
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :information_pages, [:organization_id, :slug], unique: true
  end
end