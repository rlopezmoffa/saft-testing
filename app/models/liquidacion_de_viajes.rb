class LiquidacionDeViajes < ActiveRecord::Base
  self.table_name = 'liquidaciones_de_viajes'
  self.inheritance_column = 'ruby_type'
  self.primary_key = 'id'
  belongs_to :chofer, :foreign_key => 'ch_choferes_id', :class_name => 'Chofer'
  belongs_to :vehiculo, :foreign_key => 've_vehiculos_id', :class_name => 'Vehiculo'
  belongs_to :empresa, :foreign_key => 'id_empresa', :class_name => 'Empresa'

  def self.get_ultimo_registro(matricula) 	
  	tmp = LiquidacionDeViajes.where('matricula = ?', matricula).order('co_fecha DESC').order('ch_turnos_id DESC').limit(1)
  	return tmp[0]
  end

  def get_kmts_recorridos
    begin
      return self.ve_km_sal - self.ve_km_ent  
    rescue Exception => e
      return 0      
    end    
  end

  def get_valor_km    
    begin
      return self.tot_recaudado / self.get_kmts_recorridos  
    rescue Exception => e
      return 0      
    end    
  end

  def self.calcular_valores(liquidacion_de_viajes)    
    # obtener recaudacion fichas y banderas
    liquidacion_de_viajes.re_diu_banderas = (liquidacion_de_viajes.ba_diu_sal.to_i - 
      liquidacion_de_viajes.ba_diu_ent.to_i - liquidacion_de_viajes.ba_diu_des.to_i) * 
      liquidacion_de_viajes.ba_diu_valor

    liquidacion_de_viajes.re_noc_banderas = (liquidacion_de_viajes.ba_noc_sal.to_i - 
      liquidacion_de_viajes.ba_noc_ent.to_i - liquidacion_de_viajes.ba_noc_des.to_i) * 
      liquidacion_de_viajes.ba_noc_valor

    liquidacion_de_viajes.re_diu_fichas = (liquidacion_de_viajes.fi_diu_sal.to_i - 
      liquidacion_de_viajes.fi_diu_ent.to_i - liquidacion_de_viajes.fi_diu_des.to_i) * 
      liquidacion_de_viajes.fi_diu_valor

    liquidacion_de_viajes.re_noc_fichas = (liquidacion_de_viajes.fi_noc_sal.to_i - 
      liquidacion_de_viajes.fi_noc_ent.to_i - liquidacion_de_viajes.fi_noc_des.to_i) * 
      liquidacion_de_viajes.fi_noc_valor

    liquidacion_de_viajes.tot_recaudado = liquidacion_de_viajes.re_diu_banderas + 
    liquidacion_de_viajes.re_noc_banderas +
    liquidacion_de_viajes.re_diu_fichas + 
    liquidacion_de_viajes.re_noc_fichas  

    liquidacion_de_viajes.ga_salario_comis = liquidacion_de_viajes.tot_recaudado * liquidacion_de_viajes.ch_porc_comis / 100 

    liquidacion_de_viajes.tot_gastos = liquidacion_de_viajes.ga_salario_comis + liquidacion_de_viajes.ga_salario_otros.to_f + 
    liquidacion_de_viajes.ga_gasoil.to_f + liquidacion_de_viajes.ga_aceite.to_f + liquidacion_de_viajes.ga_gomeria.to_f + 
    liquidacion_de_viajes.ga_lavado.to_f + liquidacion_de_viajes.ga_otros1_valor.to_f + liquidacion_de_viajes.ga_otros2_valor.to_f    

    liquidacion_de_viajes.tot_liquido = liquidacion_de_viajes.tot_recaudado - liquidacion_de_viajes.tot_gastos

    liquidacion_de_viajes.tot_subtotal = liquidacion_de_viajes.tot_liquido + liquidacion_de_viajes.tot_aportes.to_f

    liquidacion_de_viajes.tot_total = liquidacion_de_viajes.tot_subtotal - liquidacion_de_viajes.tot_varios.to_f    

    return liquidacion_de_viajes  
  end

  def self.recalcular_valores(lvp)
    # obtener recaudacion fichas y banderas
    lvp[:re_diu_banderas] = (lvp[:ba_diu_sal].to_i - lvp[:ba_diu_ent].to_i - 
      lvp[:ba_diu_des].to_i) * lvp[:ba_diu_valor].to_f

    lvp[:re_noc_banderas] = (lvp[:ba_noc_sal].to_i - lvp[:ba_noc_ent].to_i - 
      lvp[:ba_noc_des].to_i) * lvp[:ba_noc_valor].to_f

    lvp[:re_diu_fichas] = (lvp[:fi_diu_sal].to_i - lvp[:fi_diu_ent].to_i - 
      lvp[:fi_diu_des].to_i) * lvp[:fi_diu_valor].to_f

    lvp[:re_noc_fichas] = (lvp[:fi_noc_sal].to_i - lvp[:fi_noc_ent].to_i - 
      lvp[:fi_noc_des].to_i) * lvp[:fi_noc_valor].to_f

    lvp[:tot_recaudado] = lvp[:re_diu_banderas] + lvp[:re_noc_banderas] + lvp[:re_diu_fichas] + lvp[:re_noc_fichas]
   
    lvp[:ga_salario_comis] = lvp[:tot_recaudado].to_f * lvp[:ch_porc_comis].to_f / 100 

    lvp[:tot_gastos] = lvp[:ga_salario_comis] + lvp[:ga_salario_otros].to_f + lvp[:ga_gasoil].to_f + 
    lvp[:ga_aceite].to_f + lvp[:ga_gomeria].to_f + lvp[:ga_lavado].to_f + lvp[:ga_otros1_valor].to_f + lvp[:ga_otros2_valor].to_f    

    lvp[:tot_liquido] = lvp[:tot_recaudado] - lvp[:tot_gastos]

    lvp[:tot_subtotal] = lvp[:tot_liquido] + lvp[:tot_aportes].to_f

    lvp[:tot_total] = lvp[:tot_subtotal] - lvp[:tot_varios].to_f    

    return lvp  
  end

  def empresa_chofer
    if self.chofer.present? && self.empresa.present?
      EmpresaChofer.where(id_empresa: self.chofer.id, id_chofer: self.empresa.id).first
    end
  end

  def fecha_registro_as_json
    self.fecha_registro.present? ? self.fecha_registro.strftime("%Y-%m-%d") : nil
  end

  def as_json(options = {})
    super options.merge(methods: :fecha_registro_as_json)
  end
end
