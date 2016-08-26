class GastoAdicional < ActiveRecord::Base
  self.table_name = 'liq_vehiculos'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :matricula, :periodo, :dia, :rep_mec_valor, :rep_mec_concepto, :fijos_valor, :fijos_concepto, :aceite_valor, :aceite_concepto, :ajuste
  end
end
