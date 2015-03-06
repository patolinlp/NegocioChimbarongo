class CreateVenta < ActiveRecord::Migration
  def change
    create_table :venta do |t|
      t.integer :usuario_id
      t.integer :total
      t.boolean :terminada, default: false, null: false
      t.date :fecha
      t.integer :cliente_id
      t.integer :cuota
      t.integer :pagado, default: false, null: false
      t.integer :abono, default: 0


      t.timestamps
    end
  end
end
