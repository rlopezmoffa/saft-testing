json.array!(@tarifas) do |tarifa|
  json.extract! tarifa, :id, :fecha, :valor_ba_diu, :valor_ba_noc, :valor_fi_diu, :valor_fi_noc
  json.url tarifa_url(tarifa, format: :json)
end
