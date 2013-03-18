class AddQuantityToArticleCartAssignment < ActiveRecord::Migration
  def change
    add_column :article_cart_assignments, :quantity, :integer, :default => 1
    ArticleCartAssignment.all.each do |aca|
      aca.quantity = 1
      aca.save
    end
  end
end
