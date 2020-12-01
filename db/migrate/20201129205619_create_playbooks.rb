class CreatePlaybooks < ActiveRecord::Migration[6.0]
  def change
    create_table :playbooks do |t|
      t.string :author
      t.text :body

      t.timestamps
    end
  end
end
