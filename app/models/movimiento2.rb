class Movimiento2
attr_accessor :fecha, :tipo, :secuencia, :numero, :concepto, :debito, :credito, :saldo	
extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end

  def get_concepto
    if self.tipo == 2
      '**Nota de Credito**'      
    else
      self.concepto     
    end    
  end  
end