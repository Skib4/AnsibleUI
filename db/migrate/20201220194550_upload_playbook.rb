class UploadPlaybook < ActiveRecord::Migration[6.0]
  def change
    add_column :playbooks, :playbook, :string
  end
end
