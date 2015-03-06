class TipoProducto < ActiveRecord::Base

	#relaciones:
	has_many :productos

	#validaciones:
	validates :nombre, presence: true
	
end
