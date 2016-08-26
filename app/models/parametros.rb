class Parametros < ActiveRecord::Base
  @@meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre']

  def self.get_mes_alfa(m)
  	mes = m.to_i

	#meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre']

	if mes < 0 || mes > 12
  		mes = 1
  	end
  	return @@meses[mes - 1]
  end	
end
