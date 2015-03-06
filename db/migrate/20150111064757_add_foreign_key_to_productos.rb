class AddForeignKeyToProductos < ActiveRecord::Migration
  def change
  	add_index :productos, :tipo_producto_id
  end
end
