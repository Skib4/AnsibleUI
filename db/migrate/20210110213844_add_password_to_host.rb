class AddPasswordToHost < ActiveRecord::Migration[6.0]
  def change
    add_column :hosts, :password, :string
  end
end
