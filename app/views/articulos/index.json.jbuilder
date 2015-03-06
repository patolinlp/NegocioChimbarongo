json.array!(@articulos) do |articulo|
  json.extract! articulo, :id, :venta_id, :producto_id, :cantidad
  json.url articulo_url(articulo, format: :json)
end
