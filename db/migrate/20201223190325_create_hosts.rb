class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip_addr
      t.text :description
      t.integer :ssh_port

      t.timestamps
    end
  end
end
