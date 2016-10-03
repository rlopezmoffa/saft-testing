class EmpresaChoferesController < ApplicationController
  before_action :set_empresa_chofer, only: [:show, :edit, :update, :destroy]

  # GET /empresa_choferes
  # GET /empresa_choferes.json
  def index
    @empresa_choferes = EmpresaChofer.all
  end

  # GET /empresa_choferes/1
  # GET /empresa_choferes/1.json
  def show
  end

  # GET /empresa_choferes/new
  def new
    @empresa_chofer = EmpresaChofer.new
  end

  # GET /empresa_choferes/1/edit
  def edit
    @id_empresa = params[:id_empresa]
  end

  # POST /empresa_choferes
  # POST /empresa_choferes.json
  def create
    @empresa_chofer = EmpresaChofer.new(empresa_chofer_params)

    respond_to do |format|
      if @empresa_chofer.save
        format.html { redirect_to @empresa_chofer, notice: 'Empresa chofer was successfully created.' }
        format.json { render :show, status: :created, location: @empresa_chofer }
      else
        format.html { render :new }
        format.json { render json: @empresa_chofer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresa_choferes/1
  # PATCH/PUT /empresa_choferes/1.json
  def update    

    empresa = Empresa.find(empresa_chofer_params[:id_empresa])

    respond_to do |format|
      if @empresa_chofer.update(empresa_chofer_params)
        format.html { redirect_to empresa }      

        #format.html { redirect_to @empresa_chofer, notice: 'Empresa chofer was successfully updated.' }
        #format.json { render :show, status: :ok, location: @empresa_chofer }
      else
        format.html { render :edit }
        format.json { render json: @empresa_chofer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresa_choferes/1
  # DELETE /empresa_choferes/1.json
  def destroy
    @empresa_chofer.destroy
    respond_to do |format|
      format.html { redirect_to empresa_choferes_url, notice: 'Empresa chofer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @chofer = Chofer.where(ci_numero: params[:cedula]).first
    @empresa_chofer = @chofer.present? ? EmpresaChofer.where(id_empresa: params[:id_empresa], id_chofer: @chofer.id).first : nil
    respond_to do |format|
      format.json do
        if @empresa_chofer.present?
          render json: {empresa_chofer: @empresa_chofer}
        elsif @chofer.present?
          render json: {chofer: @chofer}
        else
          head :not_found
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa_chofer
      @empresa_chofer = EmpresaChofer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_chofer_params
      params.require(:empresa_chofer).permit(:id_empresa, :id_chofer, :estado, :fecha_alta, :fecha_baja, :turno, :hora_entrada, :hora_salida, :descanso, :fecha_alta_bps, :charla_seguro, :carne_seguro, :porc_comision, :porc_aporte, :fijo_aporte, :observaciones)
    end
end
