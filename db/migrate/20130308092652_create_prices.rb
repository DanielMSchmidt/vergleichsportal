class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :value

      t.timestamps
    end
  end
end
