class AddCustomFieldsJsonToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :custom_fields_json, :string
  end
end
