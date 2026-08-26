class MakeTransportRequestOptionalOnTransportActivities < ActiveRecord::Migration[8.1]
  def change
    change_column_null :transport_activities, :transport_request_id, true
  end
end
