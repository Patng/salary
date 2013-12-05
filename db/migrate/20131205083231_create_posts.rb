class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :company
      t.integer :salary
      t.boolean :check

      t.timestamps
    end
  end
end
