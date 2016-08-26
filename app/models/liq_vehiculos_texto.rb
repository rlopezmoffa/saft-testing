class LiqVehiculosTexto  < ActiveRecord::Base
  self.table_name = 'liq_vehiculos_textos'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :matricula, :periodo, :texto
  end

end