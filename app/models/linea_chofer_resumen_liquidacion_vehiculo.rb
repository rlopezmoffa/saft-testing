class LineaChoferResumenLiquidacionVehiculo
attr_accessor :id, :nombre, :recaudacion, :jornales, :promedio, :promedio_kmt, :aportes, :salario
	
extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end  
end