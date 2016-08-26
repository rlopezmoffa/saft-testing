class LineaLiquidacionChoferes
  attr_accessor :chofer_id, :cedula, :nombre, :jornales, :recaudacion, :salario, :observaciones, 
  :alta_bps, :taller, :licencias
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end  
  
end