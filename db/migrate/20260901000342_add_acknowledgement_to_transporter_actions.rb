class AddAcknowledgementToTransporterActions < ActiveRecord::Migration[8.1]
  def change
    add_column :transporter_actions, :requires_acknowledgement, :boolean
    add_column :transporter_actions, :acknowledgement_text, :text
  end
end
