class Ventum < ActiveRecord::Base
	#relaciones:
	#un producto tiene muchos articulos
	has_many :productos
	#un producto pertenece a un tipo de producto
	belongs_to :usuario
	
	#validaciones
	validates :usuario_id, presence: true
	validates :total, presence: true

	after_destroy :destroy_pagos

	filterrific(
		available_filters: [
			:with_fecha
		]
	)

	scope :with_fecha, lambda { |ref_date|
		where(:fecha => [*ref_date])
	}

	def destroy_pagos
		@articulos = Articulo.where(:ventum_id => self.id)
		@articulos.each do |articulo|
			articulo.destroy
		end
	end

end
