class AddVisibleToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :visible, :boolean, default: false
  end
end
