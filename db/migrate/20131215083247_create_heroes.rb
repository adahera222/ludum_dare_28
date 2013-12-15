class CreateHeroes < ActiveRecord::Migration
  def change
    create_table :heroes do |t|
      t.string :handle
      t.integer :hp
      t.integer :room
      t.boolean :sword

      t.timestamps
    end
  end
end
