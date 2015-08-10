class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.text :numbers, default: "[]", null: false

      t.timestamps null: false
    end
  end
end
