class AddOutputToRun < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :output, :text
  end
end
