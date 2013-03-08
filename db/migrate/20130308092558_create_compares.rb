class CreateCompares < ActiveRecord::Migration
  def change
    create_table :compares do |t|
      t.integer :cart_id
      t.timestamps
    end
  end
end
