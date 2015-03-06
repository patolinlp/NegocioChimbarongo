json.array!(@venta) do |ventum|
  json.extract! ventum, :id, :vendedor_id, :total, :cliente_id, :cuota
  json.url ventum_url(ventum, format: :json)
end
