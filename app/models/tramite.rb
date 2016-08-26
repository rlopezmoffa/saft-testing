class Tramite < ActiveRecord::Base
  self.table_name = 'tramites'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :empresas_id, :gestorias_id, :tramite
  end

  belongs_to :empresa, :foreign_key => 'empresas_id', :class_name => 'Empresa'
  belongs_to :gestoria, :foreign_key => 'gestorias_id', :class_name => 'Gestoria'
  
  def get_nombre_gestoria
  	begin
  	  g = Gestoria.find(self.gestorias_id)
  	  return g.gestoria
  	rescue Exception => e
  	  return ""	
  	end
  	
  end
end