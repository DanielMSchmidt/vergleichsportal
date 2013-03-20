class AddOptionsToSearchQueries < ActiveRecord::Migration
  def change
    add_column :search_queries, :options, :text
  end
end
