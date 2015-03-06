class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :codigo
      t.string :nombre
      t.integer :valor
      t.integer :tipo_producto_id
      t.integer :stock

      t.timestamps
    end
  end
end
