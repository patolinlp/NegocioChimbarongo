class AddForeignKeyToVenta < ActiveRecord::Migration
  def change
  	add_index :venta, :usuario_id
  end
end
