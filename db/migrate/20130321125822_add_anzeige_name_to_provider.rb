class AddAnzeigeNameToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :display_name, :string
  end
end
