class Proveedor < ActiveRecord::Base
	self.table_name = 'proveedores'
    self.inheritance_column = 'ruby_type'
    self.primary_key = 'id'
    has_many :servicios_realizados, :foreign_key => 'id_proveedor', :class_name => 'ServicioRealizado' 

    if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
      attr_accessible :nombre
    end
end
