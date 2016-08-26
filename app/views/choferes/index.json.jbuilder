json.array!(@choferes) do |chofer|
  json.extract! chofer, :id, :nombres, :apellidos, :apodo, :ci_numero, :ci_vencim, :lc_numero, :lc_vencim, :cs_numero, :cs_vencim, :fe_nacim, :direccion, :tel_domic, :tel_celular, :tel_contacto, :mutualista, :emergencia, :observ, :is_activo
  json.url chofer_url(chofer, format: :json)
end
