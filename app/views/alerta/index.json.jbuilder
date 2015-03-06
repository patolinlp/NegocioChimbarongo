json.array!(@alerta) do |alertum|
  json.extract! alertum, :id, :texto, :producto_id
  json.url alertum_url(alertum, format: :json)
end
