class Articulo < ActiveRecord::Base

	#relaciones:
	#un articulo pertenece a un producto
	belongs_to :producto
	#un articulo pertenece a una venta
	belongs_to :ventum

	attr_accessor :nombre_de_producto
	attr_accessor :cantidad_old

	#validaciones
	validates :ventum_id, presence: true
	validates :producto_id, presence: true
	validates :cantidad, presence: true
	validates :total, presence: true

end
