class AddRelationsToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :article_id, :integer
    add_column :prices, :provider_id, :integer
  end
end
