class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :value
      t.integer :article_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
