class CreateArticleQueryAssignments < ActiveRecord::Migration
  def change
    create_table :article_query_assignments do |t|
      t.integer :article_id
      t.integer :search_query_id

      t.timestamps
    end
  end
end
