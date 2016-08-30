class Matricula < ActiveRecord::Base
  self.table_name = 'matriculas'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :codigo, :empresa_id
  end

  belongs_to :empresa, :foreign_key => 'empresa_id', :class_name => 'Empresa'
  has_many :matriculas_log, :foreign_key => 'matricula_id', :class_name => 'MatriculasLog'
  has_many :empresas, :through => :matriculas_log, :foreign_key => 'empresa_id', :class_name => 'Empresa'
  has_many :vehiculos, :through => :matriculas_log, :foreign_key => 'vehiculo_id', :class_name => 'Vehiculo'

  def get_nombre_empresa
  	begin
  	  empresa = Empresa.find(self.empresa_id)
  	  return empresa.razon_social
  	rescue Exception => e
  	  return ""
  	end
  end

  def get_vehiculo
    operaciones = MatriculaLog.where("matricula_id = ?", self.id).order('fecha DESC').limit(1)
    vehiculo = Vehiculo.find(operaciones[0].vehiculo_id)

    #return Vehiculo.find(80)
  end

  def self.search1(search)
    where("codigo = ?", search)
  end

  def as_json(options = {})
    super(options.merge(include: :empresa))
  end

end
