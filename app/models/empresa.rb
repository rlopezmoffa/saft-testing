class Empresa < ActiveRecord::Base
  self.table_name = 'empresas'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :razon_social, :direccion, :telefonos, :contacto, :fecha_ingreso, :bps_numero, :bps_digito, :pat_socio, :rubros, :estados_id, :porc_comision
  end

  has_many :choferes, :foreign_key => 'empresas_id', :class_name => 'Chofer'
  has_many :matriculas, :foreign_key => 'empresa_id', :class_name => 'Matricula'
  has_many :matriculas_logs, :foreign_key => 'empresa_id', :class_name => 'MatriculasLog'
  has_many :tramites, :foreign_key => 'empresas_id', :class_name => 'Tramite'
  has_many :licencias, :foreign_key => 'id_empresa', :class_name => 'Licencia'
  has_many :vehiculos, :foreign_key => 'empresas_id', :class_name => 'Vehiculo'
  has_many :matriculas_by_matriculas_log, :source => :matricula, :through => :matriculas_logs, :foreign_key => 'matricula_id', :class_name => 'Matricula'
  has_many :vehiculos_by_matriculas_log, :source => :vehiculo, :through => :matriculas_logs, :foreign_key => 'vehiculo_id', :class_name => 'Vehiculo'
  has_many :gestorias, :through => :tramites, :foreign_key => 'gestorias_id', :class_name => 'Gestoria'
  has_many :liquidacion_de_viajes, :foreign_key => 'id_empresa', :class_name => 'LiquidacionDeViajes'
  has_many :empresa_choferes, :foreign_key => 'id_empresa', :class_name => 'EmpresaChoferes'


  def get_estado
    if self.estados_id == 1
      return "Activa"
    else
      return "Inactiva"
    end
  end

  def get_choferes
    EmpresaChofer.where('id_empresa = ?', self.id)
  end

  def get_choferes_activos
    EmpresaChofer.where('id_empresa = ?', self.id).where('estado = ?', 1)
  end

end