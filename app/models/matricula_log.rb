class MatriculaLog < ActiveRecord::Base
  self.table_name = 'matriculas_log'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :matricula_id, :vehiculo_id, :empresa_id, :fecha, :evento
  end

  belongs_to :empresa, :foreign_key => 'empresa_id', :class_name => 'Empresa'
  belongs_to :matricula, :foreign_key => 'matricula_id', :class_name => 'Matricula'
  belongs_to :vehiculo, :foreign_key => 'vehiculo_id', :class_name => 'Vehiculo'

  def get_marca_vehiculo
    begin
      vehiculo = Vehiculo.find(self.vehiculo_id)
  	  return vehiculo.marca
  	rescue Exception => e
  	  return ""	
  	end
  end

  def get_padron
    begin
      vehiculo = Vehiculo.find(self.vehiculo_id)
      return vehiculo.padron
    rescue Exception => e
      return "" 
    end
  end

  def get_nombre_empresa
    begin
  	  empresa = Empresa.find(self.empresa_id)
  	  return empresa.razon_social
  	rescue Exception => e
  	  return ""	
  	end
  end

  def get_evento
  	if self.evento == 1 
  	  return "ALTA"
  	end

  	if self.evento == 10
  	  return "ASIGNADA"
  	end

  	if self.evento == 20
  	  return "LIBRE" 
  	end
  	
  	return ""   
  end
end
