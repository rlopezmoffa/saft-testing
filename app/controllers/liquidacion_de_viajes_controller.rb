class LiquidacionDeViajesController < ApplicationController
  before_action :set_default_date, only: [:new, :edit]
  before_action :set_default_comision, only: [:new, :edit]

  def index
    @liquidacion_de_viajes = LiquidacionDeViajes.all
  end

  def show
    @liquidacion_de_viaje = LiquidacionDeViajes.find(params[:id])
  end

  def new
    @tarifa = Tarifa.order('fecha DESC').first
  end

  def edit
    @liquidacion_de_viaje = LiquidacionDeViajes.find(params[:id])
    @tarifa = Tarifa.order('fecha DESC').first
  end

  def create
    @liquidacion_de_viaje = LiquidacionDeViajes.new(liquidacion_de_viaje_params)

    respond_to do |format|
      if @liquidacion_de_viaje.save
        format.html { redirect_to liquidacion_de_viajes_index_path, notice: 'Se ha creado el registro.' }
        format.json { render json: @liquidacion_de_viaje, status: :created, location: liquidacion_de_viajes_index_path }
      else
        format.html { render :new }
        format.json { render json: @liquidacion_de_viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @liquidacion_de_viaje = LiquidacionDeViajes.find(params[:id])

    respond_to do |format|
      if @liquidacion_de_viaje.update(liquidacion_de_viaje_params)
        format.html { redirect_to liquidacion_de_viajes_index_path, notice: 'Actualizacion realizada.' }
        format.json { render json: @liquidacion_de_viaje, status: :created, location: liquidacion_de_viajes_index_path }
      else
        format.html { render :edit }
        format.json { render json: @liquidacion_de_viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    liquidacion_de_viaje = LiquidacionDeViajes.find(params[:id])
    liquidacion_de_viaje.destroy

    redirect_to liquidacion_de_viajes_index_path
  end

  def last
    @last = LiquidacionDeViajes.get_ultimo_registro(params[:matricula])

    if @last.present?
      render json: @last
    else
      head :not_found
    end
  end

  def liquidacion_de_viaje_params
    params.require(:liquidacion_de_viaje).permit(:matricula, :co_fecha, :id_empresa, :ve_km_ent, :ve_km_sal, :ch_choferes_id, :ch_turnos_id, :ch_porc_comis, :ba_diu_ent, :ba_diu_sal, :ba_diu_des, :ba_diu_valor, :ba_noc_ent, :ba_noc_sal, :ba_noc_des, :ba_noc_valor, :fi_diu_ent, :fi_diu_sal, :fi_diu_des, :fi_diu_valor, :fi_noc_ent, :fi_noc_sal, :fi_noc_des, :fi_noc_valor, :ga_salario_otros, :ga_gasoil, :ga_aceite, :ga_gomeria, :ga_lavado, :ga_otros1_valor, :ga_otros1_detalle, :ga_otros2_valor, :ga_otros2_detalle, :re_otros_mas, :re_otros_menos, :tot_aportes, :tot_varios, :recaudacion_digitada, :observ)
  end

  def set_default_date
    @default_date = Time.now.strftime("%Y-%m-%d")
  end

  def set_default_comision
    @default_comision = 27.0
  end
end
