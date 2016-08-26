class Tarifa < ActiveRecord::Base
  self.table_name = 'tarifas'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :fecha, :valor_ba_diu, :valor_ba_noc, :valor_fi_diu, :valor_fi_noc
  end  

  def self.get_valor_bandera_diurna
    tmp = Tarifa.order('fecha DESC').limit(1)
    return tmp[0].valor_ba_diu
  end

  def self.get_valor_bandera_nocturna
    tmp = Tarifa.order('fecha DESC').limit(1)
    return tmp[0].valor_ba_noc
  end
  
  def self.get_valor_ficha_diurna
    tmp = Tarifa.order('fecha DESC').limit(1)
    return tmp[0].valor_fi_diu
  end

  def self.get_valor_ficha_nocturna
    tmp = Tarifa.order('fecha DESC').limit(1)
    return tmp[0].valor_fi_noc
  end

end
