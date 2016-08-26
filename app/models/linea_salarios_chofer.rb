class LineaSalariosChofer
attr_accessor :fecha, :recaudado, :salario, :matricula, :jornales
	
extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end

  
end