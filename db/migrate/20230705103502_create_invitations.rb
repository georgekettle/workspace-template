class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :token
      t.references :workspace, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
    add_index :invitations, :token
  end
end
