class AddPasswordsshToHost < ActiveRecord::Migration[6.0]
  def change
    add_column :hosts, :passwordssh, :string
  end
end
