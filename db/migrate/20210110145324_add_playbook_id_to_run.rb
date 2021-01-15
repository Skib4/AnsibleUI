class AddPlaybookIdToRun < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :playbook_id, :integer
    add_index :runs, :playbook_id
  end
end
