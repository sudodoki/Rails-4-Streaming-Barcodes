class CreateRoleAttachments < ActiveRecord::Migration
  def change
    create_table :role_attachments do |t|
      t.references :role, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
