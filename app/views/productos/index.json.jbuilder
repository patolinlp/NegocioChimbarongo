json.array!(@productos) do |producto|
  json.extract! producto, :id, :codigo, :nombre, :valor, :tipo_producto, :stock
  json.url producto_url(producto, format: :json)
end
