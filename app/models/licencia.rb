class Licencia < ActiveRecord::Base
  self.table_name = 'licencias'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :id_empresa, :id_chofer, :cedula, :motivo, :fecha_desde, :fecha_hasta, :importe, :salario_vacacional
  end

  belongs_to :empresa, :foreign_key => 'id_empresa', :class_name => 'Empresa'
  belongs_to :chofer, :foreign_key => 'id_chofer', :class_name => 'Chofer'

  def get_motivo
  	if self.motivo == 0
      return "LICENCIA REGLAMENTARIA"
	  end

	  if self.motivo == 1
      return "DISSE"
	  end

    if self.motivo == 2
      return "BSE"
    end

    if self.motivo == 3
      return "SEGURO DE PARO"
    end

    if self.motivo == 4
      return "LICENCIA EXTRAORDINARIA"
    end

	  return ""
  end

end
