class EmpresaChofer < ActiveRecord::Base
	self.table_name = 'empresa_chofer'
	self.inheritance_column = 'ruby_type'
	self.primary_key = 'id'

	if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
	  attr_accessible :id_empresa, :id_chofer, :estado, :fecha_alta, :fecha_baja, :turno, :hora_entrada, :hora_salida, :descanso, :fecha_alta_bps, :charla_seguro, :carne_seguro, :porc_comision, :porc_aporte, :fijo_aporte, :observaciones, :mark_for_delete
	end

	belongs_to :empresa, :foreign_key => 'id_empresa', :class_name => 'Empresa'
	belongs_to :chofer, :foreign_key => 'id_chofer', :class_name => 'Chofer'

	def get_fecha_alta_editada
	  if self.fecha_alta != nil
	    return self.fecha_alta.strftime("%d/%m/%Y")	  
	  end
	end

	def get_fecha_baja_editada
	  if self.fecha_baja != nil
	    return self.fecha_baja.strftime("%d/%m/%Y")	  
	  end
	end

	def get_fecha_alta_bps_editada
	  if self.fecha_alta_bps != nil
	    return self.fecha_alta_bps.strftime("%d/%m/%Y")	  
	  end
	end

	def get_estado_alfa
	  if self.estado == 1
	  	return 'Activo'
	  end
	  return 'Inactivo'
	end

	def get_turno_alfa
	  if self.turno == 1
	  	return 'Diurno'
	  end
	  return 'Nocturno'
	end

	def get_nombre_chofer
	  chofer = self.chofer
	  if chofer != nil
	    return chofer.get_nombre_completo
	  end
	  return "*** ERROR - Chofer inexistente ***"
	end

  def as_json(options = {})
    super options.merge(include: :chofer)
  end

end
