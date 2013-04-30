class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string  :name
      t.boolean :read_admin
      t.boolean :write_admin

      t.timestamps
    end
  end
end
