class LineaCorreaDistribucion
attr_accessor :matricula, :fecha, :kmts_realizado, :kmts_recorridos, 
	:kmts_vehiculo, :fecha_cierre
	
extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end

  
end