class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.integer :cantidad
      t.integer :producto_id
      t.integer :ventum_id
      t.integer :total

      t.timestamps
    end
  end
end
