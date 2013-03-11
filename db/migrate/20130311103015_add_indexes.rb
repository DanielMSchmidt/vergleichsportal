class AddIndexes < ActiveRecord::Migration
  def up
    add_index :article_cart_assignments, :article_id
    add_index :article_cart_assignments, :cart_id
    add_index :article_query_assignments, :article_id
    add_index :article_query_assignments, :search_query_id
    add_index :carts, :user_id
    add_index :comments, :user_id
    add_index :comments, [ :commentable_type, :commentable_id]
    add_index :compares, :cart_id
    add_index :images, [ :imageable_type, :imageable_id]
    add_index :permission_role_assignments, :role_id
    add_index :permission_role_assignments, :permission_id
    add_index :prices, :article_id
    add_index :prices, :provider_id
    add_index :ratings, :user_id
    add_index :ratings, :provider_id
    add_index :ratings, [ :rateable_type, :rateable_id]
    add_index :user_role_assignments, :user_id
    add_index :user_role_assignments, :role_id
    add_index :users, :role_id
  end

  def down
    remove_index :article_cart_assignments, :article_id
    remove_index :article_cart_assignments, :cart_id
    remove_index :article_query_assignments, :article_id
    remove_index :article_query_assignments, :search_query_id
    remove_index :carts, :user_id
    remove_index :comments, :user_id
    remove_index :comments, [ :commentable_type, :commentable_id]
    remove_index :compares, :cart_id
    remove_index :images, [ :imageable_type, :imageable_id]
    remove_index :permission_role_assignments, :role_id
    remove_index :permission_role_assignments, :permission_id
    remove_index :prices, :article_id
    remove_index :prices, :provider_id
    remove_index :ratings, :user_id
    remove_index :ratings, :provider_id
    remove_index :ratings, [ :rateable_type, :rateable_id]
    remove_index :user_role_assignments, :user_id
    remove_index :user_role_assignments, :role_id
    remove_index :users, :role_id
  end
end
