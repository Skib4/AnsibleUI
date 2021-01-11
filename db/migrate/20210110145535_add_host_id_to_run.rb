class AddHostIdToRun < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :host_id, :integer
    add_index :runs, :host_id
  end
end
