json.array!(@empresa_choferes) do |empresa_chofer|
  json.extract! empresa_chofer, :id, :id_empresa, :id_chofer, :estado, :fecha_alta, :fecha_baja, :turno, :hora_entrada, :hora_salida, :descanso, :fecha_alta_bps, :charla_seguro, :carne_seguro, :porc_comision, :porc_aporte, :fijo_aporte, :observaciones
  json.url empresa_chofer_url(empresa_chofer, format: :json)
end
