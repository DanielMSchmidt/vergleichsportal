class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
