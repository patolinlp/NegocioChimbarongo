class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :apellido
      t.integer :rut
      t.boolean :credito
      t.string :direccion
      t.integer :telefono
      t.string :nombre_aval
      t.string :apellido_aval
      t.integer :rut_aval

      t.timestamps
    end
  end
end
