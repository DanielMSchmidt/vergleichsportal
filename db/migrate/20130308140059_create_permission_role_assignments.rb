class CreatePermissionRoleAssignments < ActiveRecord::Migration
  def change
    create_table :permission_role_assignments do |t|
      t.integer :role_id
      t.integer :permission_id

      t.timestamps
    end
  end
end
