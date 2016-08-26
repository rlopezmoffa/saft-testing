class Chofer < ActiveRecord::Base
  self.table_name = 'choferes'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'

  if ActiveRecord::VERSION::STRING < '4.0.0' || defined?(ProtectedAttributes)
    attr_accessible :nombres, :apellidos, :apodo, :ci_numero, :ci_vencim, :cc_numero, :lc_numero, :lc_vencim, :cs_numero, :cs_vencim, :bps_numero, :bps_ingreso, :seg_numero, :fe_nacim, :fe_ingreso, :direccion, :tel_domic, :tel_celular, :tel_contacto, :mutualista, :emergencia, :empresas_id, :comision, :observ, :estados_id, :flag_bps, :flag_efectivo, :is_activo, :fecha_registro
  end

  has_many :liquidacion_de_viajes, :foreign_key => 'ch_choferes_id', :class_name => 'LiquidacionDeViajes'
  has_many :licencias, :foreign_key => 'id_chofer', :class_name => 'Licencia'
  belongs_to :empresa, :foreign_key => 'empresas_id', :class_name => 'Empresa'

  has_many :empresa_choferes, :foreign_key => 'id_chofer', :class_name => 'EmpresaChoferes'

  def get_nombre_completo
  	return self.nombres + ' ' + self.apellidos
  end

  def self.search2(search)  
    where("ci_numero = ?", search)    
  end

  def get_comision(empresa_id)    
    tmp = EmpresaChofer.where('id_empresa = ? AND id_chofer = ?', empresa_id, self.id).limit(1)    
    if tmp.any?
      return tmp[0].porc_comision      
    else
      tmp = EmpresaChofer.where('id_empresa = ? AND id_chofer = ?', 55, self.id).limit(1)    
      if tmp.any?
        return tmp[0].porc_comision      
      end            
    end
    return 0
  end

  def self.edita_cedula(x)   

    ary = x.split(//)
    l = ary.count

    str = ''
    if x.to_i > 999999
      str << ary[0]
      str << '-'
    end

    for i in l-7..l-5
      str << ary[i]
    end
    str << '-'

    for i in l-4..l-2
      str << ary[i]
    end
    str << '-'

    str << ary[l-1]
    return str
  end

  def get_fecha_alta_bps(empresa_id)
    tmp = EmpresaChofer.where('id_empresa = ? AND id_chofer = ?', empresa_id, self.id)
    if tmp.any?
      return tmp[0].fecha_alta_bps.strftime("%d/%m/%Y")
    end
    return ''
  end

  def get_dias_que_faltan_para_vencimiento_libreta(fecha)
    if Date.valid_date?(self.lc_vencim.year, self.lc_vencim.month, self.lc_vencim.day)   
      vencimiento = Date.new(self.lc_vencim.year, self.lc_vencim.month, self.lc_vencim.day) 
      return (vencimiento - fecha).to_i      
    end
    return ''
  end

  def get_dias_que_faltan_para_vencimiento_cedula(fecha)
    if Date.valid_date?(self.ci_vencim.year, self.ci_vencim.month, self.ci_vencim.day)   
      vencimiento = Date.new(self.ci_vencim.year, self.ci_vencim.month, self.ci_vencim.day) 
      return (vencimiento - fecha).to_i      
    end
    return ''
  end

  def get_dias_que_faltan_para_vencimiento_carne_salud(fecha)
    if Date.valid_date?(self.cs_vencim.year, self.cs_vencim.month, self.cs_vencim.day)   
      vencimiento = Date.new(self.cs_vencim.year, self.cs_vencim.month, self.cs_vencim.day) 
      return (vencimiento - fecha).to_i      
    end
    return ''
  end

  def get_fecha_vencimiento_libreta
    return self.lc_vencim.strftime("%d/%m/%Y") 
  end

  def get_fecha_vencimiento_cedula
    return self.ci_vencim.strftime("%d/%m/%Y") 
  end

  def get_fecha_vencimiento_carne_salud
    return self.cs_vencim.strftime("%d/%m/%Y") 
  end

end
