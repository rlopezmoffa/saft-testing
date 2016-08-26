class Vehiculo < ActiveRecord::Base
  self.table_name = 'vehiculos'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :matricula, :marca, :seguro, :padron, :motor, :empresas_id, :estados_id, :id_combustible, :id_ultimo_viaje_realizado
  end

  belongs_to :empresa, :foreign_key => 'empresas_id', :class_name => 'Empresa'
  has_many :matriculas_log, :foreign_key => 'vehiculo_id', :class_name => 'MatriculasLog'
  has_many :empresas, :through => :matriculas_log, :foreign_key => 'empresa_id', 
  :class_name => 'Empresa'
  has_many :matriculas, :through => :matriculas_log, :foreign_key => 'matricula_id', 
  :class_name => 'Matricula'
  has_many :servicios_realizados, :foreign_key => 'id_vehiculo', 
  :class_name => 'ServicioRealizado' 

  has_many :liquidaciones_de_viajes, :foreign_key => 've_vehiculos_id', 
  :class_name => 'Liquidacion_de_viajes'

  def get_kmts_ultimo_viaje
    if self.id_ultimo_viaje_realizado != nil
      ultimo_viaje = LiquidacionDeViajes.find(self.id_ultimo_viaje_realizado)
      return ultimo_viaje.ve_km_sal
    end
    return 0
  end

  def get_fecha_ultimo_viaje
    if self.id_ultimo_viaje_realizado != nil
      ultimo_viaje = LiquidacionDeViajes.find(self.id_ultimo_viaje_realizado)
      return ultimo_viaje.co_fecha.strftime("%d/%m/%Y")
    end
    return ""
  end
end
