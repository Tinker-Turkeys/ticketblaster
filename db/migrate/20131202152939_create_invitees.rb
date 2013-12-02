class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.references :event, index: true
      t.references :registration, index: true
      t.string :name
      t.string :email
      t.string :phone_number
    end
  end
end
