class ServicioRealizado < ActiveRecord::Base	
  self.table_name = 'servicios_realizados'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'
  belongs_to :vehiculo, :foreign_key => 'id_vehiculo', :class_name => 'Vehiculo'
  belongs_to :proveedor, :foreign_key => 'id_proveedor', :class_name => 'Proveedor'
  belongs_to :rubro_mantenimiento, :foreign_key => 'id_servicio', :class_name => 'RubroMantenimiento'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :fecha, :kmts_vehiculo, :fecha_proximo, :kmts_proximo, 
    :materiales, :mano_de_obra, :id_servicio, :id_proveedor, :id_vehiculo, 
    :cantidad, :matricula
  end

  def get_fecha_proximo
    if self.fecha_proximo != nil
      self.fecha_proximo.strftime("%d/%m/%Y")
    end
  end

  def get_nombre_rubro
    begin
      return self.rubro_mantenimiento.descripcion  
    rescue Exception => e
      
    end    
  end

  def self.search(search)  
    where("matricula LIKE ?", "%#{search}%")
    #where('nombre LIKE :search OR concepto LIKE :search', search: "%#{search}%")
  end
end