class AddCanceledToEvents < ActiveRecord::Migration
  def change
    add_column :events, :canceled, :boolean, default: false
  end
end
