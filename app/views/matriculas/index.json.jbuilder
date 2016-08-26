json.array!(@matriculas) do |matricula|
  json.extract! matricula, :id, :codigo, :empresa_id
  json.url matricula_url(matricula, format: :json)
end
