class AddFinalizedTokenToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :finalized, :boolean, default: false
    add_column :registrations, :token, :string
  end
end
