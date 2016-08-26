class LineaVencimientoDocumentacionChoferes
attr_accessor :cedula, :nombre, :vencimiento, :dias 	
	
extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end

  
end