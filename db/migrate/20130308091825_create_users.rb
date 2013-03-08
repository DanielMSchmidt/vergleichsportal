class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.boolean :active
      t.integer :role_id

      t.timestamps
    end
  end
end
