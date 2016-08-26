class LineaLiquidacionVehiculo
  attr_accessor :matricula, :fecha, :diurno, :nocturno, :recaudacion, :comision, :combustible,
  :lavado, :aceite, :rep_mecanicas, :gastos_fijos, :aportes, :subtotal, :ganancia, :ch_hora_ent, 
  :detalle, :otros
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end  

  def get_otros
  	result = 0
  	if self.rep_mecanicas != nil
  	  result += self.rep_mecanicas
    end

    if self.otros != nil
  	  result += self.otros
    end
    
  	return result
  end
end