class CreateBarcodes < ActiveRecord::Migration
  def change
    create_table :barcodes do |t|
      t.string :code
      t.references :user, index: true

      t.timestamps
    end
  end
end
