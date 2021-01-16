class AddRunsnumberToPlaybook < ActiveRecord::Migration[6.0]
  def change
    add_column :playbooks, :runsnumber, :integer, default: 0
  end
end
