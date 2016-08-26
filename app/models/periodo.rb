class Periodo < ActiveRecord::Base
  def get_status
  	if self.status == 1
  	  return "Abierto"
  	end
  	return "Cerrado"
  end
end
