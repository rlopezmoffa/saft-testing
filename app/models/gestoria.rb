class Gestoria < ActiveRecord::Base
  self.table_name = 'gestorias'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :gestoria
  end

  has_many :tramites, :foreign_key => 'gestorias_id', :class_name => 'Tramite'
  has_many :empresas, :through => :tramites, :foreign_key => 'empresas_id', :class_name => 'Empresa'
end
