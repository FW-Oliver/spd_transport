class SetDefaultActiveForLocations < ActiveRecord::Migration[8.1]
  def change
    change_column_default :locations, :active, from: nil, to: true
  end
end