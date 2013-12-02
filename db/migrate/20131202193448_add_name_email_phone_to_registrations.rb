class AddNameEmailPhoneToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :name, :string
    add_column :registrations, :email, :string
    add_column :registrations, :phone_number, :string
  end
end
