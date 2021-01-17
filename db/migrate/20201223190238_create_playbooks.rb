class CreatePlaybooks < ActiveRecord::Migration[6.0]
  def change
    create_table :playbooks do |t|
      t.string :author
      t.text :description
      t.string :name
      t.string :url
      t.text :body
      t.string :path
      t.timestamps
    end
  end
end
