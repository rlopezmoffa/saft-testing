class RubroMantenimiento < ActiveRecord::Base
  self.table_name = 'rubros_mantenimiento'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'
  has_many :servicios_realizados, :foreign_key => 'id_servicio', :class_name => 'ServicioRealizado' 

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :descripcion, :frecuencia_meses, :frecuencia_kmts, 
   			:categoria_id, :es_correa_distribucion
  end

  def get_es_correa_distribucion
  	if self.es_correa_distribucion == 1
  	  return true
    end  	
  	return false
  end  

  def get_es_correa_distribucion_alfa
    if self.es_correa_distribucion == 1
      return "SI"
    else
      return ""
    end
  end  

  def get_nombre_categoria  
    begin
      categoria = CategoriaMantenimiento.find(self.categoria_id)
      return categoria.denominacion  
    rescue Exception => e
      return ''      
    end
  end  
    
end
