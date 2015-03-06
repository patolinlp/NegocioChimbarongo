class CreateAlerta < ActiveRecord::Migration
  def change
    create_table :alerta do |t|
      t.string :texto
      t.integer :producto_id

      t.timestamps
    end
  end
end
