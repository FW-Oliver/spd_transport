class SetDefaultForTransporterActionAcknowledgement < ActiveRecord::Migration[8.1]
  def change
    change_column_default :transporter_actions,
                          :requires_acknowledgement,
                          from: nil,
                          to: false
  end
end
