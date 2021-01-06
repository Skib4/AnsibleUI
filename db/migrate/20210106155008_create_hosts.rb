class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip_addr
      t.string :description
      t.integer :ssh_port
      t.string :ssh_user
      t.string :password_digest

      t.timestamps
    end
  end
end
