class CreateAdvertisments < ActiveRecord::Migration
  def change
    create_table :advertisments do |t|
      t.string :img_url
      t.string :link_url
      t.boolean :active

      t.timestamps
    end
  end
end
