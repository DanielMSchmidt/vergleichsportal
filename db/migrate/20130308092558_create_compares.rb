class CreateCompares < ActiveRecord::Migration
  def change
    create_table :compares do |t|

      t.timestamps
    end
  end
end
