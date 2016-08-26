class ChoferesController < ApplicationController
  before_action :set_chofer, only: [:show, :edit, :update, :destroy]

  # GET /choferes
  # GET /choferes.json
  def index
    if params[:estado]      
      @estado = params[:estado].to_i       
      @choferes = Chofer.all.order("apellidos ASC")
    end   
  end

  # GET /choferes/1
  # GET /choferes/1.json
  def show
  end

  # GET /choferes/new
  def new
    @chofer = Chofer.new
  end

  # GET /choferes/1/edit
  def edit
  end

  # POST /choferes
  # POST /choferes.json
  def create
    @chofer = Chofer.new(chofer_params)

    respond_to do |format|
      if @chofer.save
        format.html { redirect_to @chofer, notice: 'Se ha creado el registro del chofer.' }
        format.json { render :show, status: :created, location: @chofer }
      else
        format.html { render :new }
        format.json { render json: @chofer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /choferes/1
  # PATCH/PUT /choferes/1.json
  def update
    respond_to do |format|
      if @chofer.update(chofer_params)
        format.html { redirect_to @chofer, notice: 'Actualizacion realizada.' }
        format.json { render :show, status: :ok, location: @chofer }
      else
        format.html { render :edit }
        format.json { render json: @chofer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /choferes/1
  # DELETE /choferes/1.json
  def destroy
    @chofer.destroy
    respond_to do |format|
      format.html { redirect_to choferes_url, notice: 'Chofer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chofer
      @chofer = Chofer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chofer_params
      params.require(:chofer).permit(:nombres, :apellidos, :apodo, :ci_numero, :ci_vencim, :lc_numero, :lc_vencim, :cs_numero, :cs_vencim, :fe_nacim, :direccion, :tel_domic, :tel_celular, :tel_contacto, :mutualista, :emergencia, :observ, :is_activo)
    end
end
