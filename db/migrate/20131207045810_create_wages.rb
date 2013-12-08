class CreateWages < ActiveRecord::Migration
  def change
    create_table :wages do |t|
      t.string :title
      t.string :company
      t.integer :location_id
      t.integer :total
      t.integer :avg
      t.integer :high
      t.integer :low

      t.timestamps
    end
  end
end
