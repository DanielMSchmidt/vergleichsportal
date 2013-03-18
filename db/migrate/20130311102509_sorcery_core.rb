class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.boolean :active,          :default => true
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end