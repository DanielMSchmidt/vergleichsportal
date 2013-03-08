class CreateArticleCartRelations < ActiveRecord::Migration
  def change
    create_table :article_cart_relations do |t|
      t.integer :article_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
