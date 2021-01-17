class CreateRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :runs do |t|
      t.text :command
      t.string :playbook_path
      t.string :author
      t.string :hostname
      t.string :playbook_name
      t.timestamps
    end
  end
end
