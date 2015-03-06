class PagosController < ApplicationController
	layout "dashboard"

	def index
		@clientes = Cliente.all
	end

	def edit

	end

	def seleccionar
		@clientes = Cliente.all
	end

	def pagos
		@venta = Ventum.where(:cliente_id => params[:id])
	end

	def pagar
		@ventum = Ventum.find(params[:id])
		@ventum.pagado = true
		@ventum.save!

		flash[:notice] = "La venta ha sido pagada con exito"
		redirect_to action: "index"
	end

	def abonar
		if session[:ventum_id] == nil
			session[:ventum_id] = params[:id].to_i
		end
		@ventum = Ventum.find(session[:ventum_id])
		@articulos = Articulo.where(:ventum_id => @ventum.id)
	end

	def agregar_abono
		abono_actual = params[:abono].to_i
		@ventum = Ventum.find(session[:ventum_id])
		@ventum.abono += abono_actual

		if @ventum.abono > @ventum.total
			flash[:notice] = "Error - El abono es mayor que el total de la venta"
			redirect_to action: "abonar"
		elsif @ventum.abono = @ventum.total
			@ventum.pagado = true
			@ventum.save!
			session[:ventum_id] = nil
			flash[:notice] = "Se ha realizado el abono con exito"	
			redirect_to action: "index"
		else
			@ventum.save!
			session[:ventum_id] = nil
			flash[:notice] = "Se ha realizado el abono con exito"
			redirect_to action: "index"
		end
		
	end
end
