class Producto < ActiveRecord::Base

	#relaciones:
	#un producto tiene muchos articulos
	has_many :articulos
	#un producto tiene una alerta
	has_one :alerta
	#un producto pertenece a un tipo de producto
	belongs_to :tipo_producto

	after_save :revisar_alerta

	#validaciones
	validates :codigo, presence: true, uniqueness: true
	validates :nombre, presence: true
	validates :valor, presence: true
	validates :tipo_producto_id, presence: true
	validates :stock, presence: true

	filterrific(
		available_filters: [
			:with_codigo
		]
	)

	scope :with_codigo, lambda { |ref_codigo|
		where(:codigo => [*ref_codigo])
	}

	def revisar_alerta
		if self.stock < 6
			alert = Alertum.find_by(:producto_id => self.id)
			if alert == nil
				alerta = Alertum.create(:texto => self.nombre + " tiene un stock de " + self.stock.to_s + " productos", :producto_id => self.id)
			else
				alert.texto = self.nombre + " tiene un stock de " + self.stock.to_s + " productos"
				alert.save!
			end

		else
			alert = Alertum.find_by(:producto_id => self.id)
			if alert != nil
				alert.destroy
			end
		end
	end

end
