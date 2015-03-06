class VentaController < ApplicationController
  layout "dashboard"
  before_action :set_ventum, only: [:show, :edit, :update, :destroy]

  # GET /venta
  # GET /venta.json
  def index
    @filterrific = initialize_filterrific(
      Ventum,
      params[:filterrific]
    ) or return
    
    @venta = Ventum.filterrific_find(@filterrific).paginate(:page => params[:page])
    

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /venta/1
  # GET /venta/1.json
  def show
    @articulos = Articulo.where(:ventum_id => params[:id])
  end

  # GET /venta/new
  def new
    @ventum = Ventum.create(:usuario_id => current_usuario.id, :total => 0, :fecha => Date.today )
    session[:ventum_id] = @ventum.id
  end

  def articulos
    @ventum = Ventum.find(session[:ventum_id].to_i)
    if @ventum.cliente_id == nil
      @ventum.pagado = true
      @ventum.save!
    end
    @articulos = Articulo.where(:ventum_id => session[:ventum_id])
  end

  def articulos_credito
    @ventum = Ventum.find(session[:ventum_id].to_i)
    if @ventum.cliente_id == nil
      @ventum.pagado = true
      @ventum.save!
    end
    @articulos = Articulo.where(:ventum_id => session[:ventum_id])
  end

  def credito
    @ventum = Ventum.find(session[:ventum_id].to_i)
    @clientes = Cliente.all
  end

  def seleccionar_cliente
    @ventum = Ventum.find(session[:ventum_id].to_i)
    @ventum.cliente_id = params[:cliente].to_i
    @ventum.save!
    flash[:notice] = "El cliente ha sido seleccionado"
    redirect_to action: "articulos_credito"
  end

  def agregar_articulos
    @ventum = Ventum.find(session[:ventum_id].to_i)
    producto = Producto.find_by(:codigo => params[:codigo])
    if producto == nil
      flash[:notice] = "El producto no se encuentra disponible"
      redirect_to action: "articulos" 
      
    else
      articulo_existente = Articulo.find_by(:ventum_id => @ventum.id, :producto_id => producto.id)

      if articulo_existente != nil
        articulo_existente.cantidad = articulo_existente.cantidad + params[:cantidad].to_i
        @ventum.total += producto.valor * params[:cantidad].to_i
        @ventum.save!
        articulo_existente.save!
        flash[:notice] = "El producto se ha modificado correctamente"
        redirect_to action: "articulos"
      elsif producto
        articulo = Articulo.create(:ventum_id => session[:ventum_id], :producto_id => producto.id, :cantidad => params[:cantidad], :total => params[:cantidad].to_i * producto.valor) 
        @ventum.total += producto.valor * params[:cantidad].to_i
        @ventum.save!
        flash[:notice] = "El producto se ha agregado correctamente"
        redirect_to action: "articulos"
      else
        flash[:notice] = "El producto no se encuentra disponible"
        redirect_to action: "articulos"
      end
    end
  end

  def venta_lista
    @ventum = Ventum.find(session[:ventum_id].to_i)
    @articulos = Articulo.where(:ventum_id => session[:ventum_id])

    aux = true
    @articulos.each do |a|
      aux = false
    end

    if !aux
      @ventum.terminada = true
      @articulos.each do |a|
        producto = Producto.find(a.producto_id)
        producto.stock -= a.cantidad
        producto.save!
      end
      @ventum.save!
    end
    flash[:notice] = 'La venta ha sido guardada con exito'
    redirect_to @ventum 
  end

  def cancelar_venta
    @ventum = Ventum.find(session[:ventum_id].to_i)
    @articulos = Articulo.where(:ventum_id => @ventum.id)

    @ventum.destroy
    flash[:notice] = "No se ha guardado la venta"
    redirect_to :venta
  end

  # GET /venta/1/edit
  def edit
  end

  # POST /venta
  # POST /venta.json
  def create
    @ventum = Ventum.new(ventum_params)

    respond_to do |format|
      if @ventum.save
        @carrito.each  do |c|
          @articulo = Articulo.create({:venta_id => @ventum.id, :producto_id => c.producto.id, :cantidad => c.cantidad})
        end
        format.html { redirect_to @ventum, notice: 'La venta ha sido guardada con exito' }
        format.json { render action: 'show', status: :created, location: @ventum }
      else
        format.html { render action: 'new' }
        format.json { render json: @ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venta/1
  # PATCH/PUT /venta/1.json
  def update
    respond_to do |format|
      if @ventum.update(ventum_params)
        format.html { redirect_to @ventum, notice: 'La venta ha sido actualizada con exito' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venta/1
  # DELETE /venta/1.json
  def destroy
    @ventum.destroy
    respond_to do |format|
      format.html { redirect_to venta_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventum
      @ventum = Ventum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventum_params
      params.require(:ventum).permit(:usuario_id, :total)
    end

end
