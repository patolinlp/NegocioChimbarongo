class AddForeignKeyToAlerta < ActiveRecord::Migration
  def change
  	add_index :alerta, :producto_id
  end
end
