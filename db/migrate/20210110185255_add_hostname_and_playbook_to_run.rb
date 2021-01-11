class AddHostnameAndPlaybookToRun < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :hostname, :string
    add_column :runs, :playbook_name, :string
  end
end
