class AddTimezonePreferenceToOrganizations < ActiveRecord::Migration[8.1]
  def change
    add_column :organizations, :timezone_preference, :string
  end
end
