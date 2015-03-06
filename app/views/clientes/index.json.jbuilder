json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nombre, :apellido, :rut, :credito, :direccion, :telefono, :nombre_aval, :apellido_aval, :rut_aval
  json.url cliente_url(cliente, format: :json)
end
