class CategoriaMantenimiento < ActiveRecord::Base
	self.table_name = 'categorias_mantenimiento'
    self.inheritance_column = 'ruby_type'
    self.primary_key = 'id'

    if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
      attr_accessible :denominacion
    end
end
