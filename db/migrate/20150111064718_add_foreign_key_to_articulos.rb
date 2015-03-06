class AddForeignKeyToArticulos < ActiveRecord::Migration
  def change
  	add_index :articulos, :ventum_id
  	add_index :articulos, :producto_id
  end
end
