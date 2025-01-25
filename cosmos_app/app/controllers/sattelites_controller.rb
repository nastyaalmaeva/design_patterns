class SattelitesController < ApplicationController
  before_action :set_sattelite, only: [:show, :edit, :update, :destroy, :confirm_delete]

  # GET /sattelites
  def index
    @sattelites = Sattelite.all
  end

  # GET /sattelites/:id
  def show
  end

  # GET /sattelites/new
  def new
    @sattelite = Sattelite.new
  end

  # GET /sattelites/:id/edit
  def edit
  end

  # POST /sattelites
  def create
    @sattelite = Sattelite.new(sattelite_params)
    if @sattelite.save
      redirect_to @sattelite, notice: 'Sattelite was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sattelites/:id
  def update
    if @sattelite.update(sattelite_params)
      redirect_to @sattelite, notice: 'Sattelite was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sattelites/:id
  def destroy
    @sattelite.destroy
    redirect_to sattelites_path, notice: 'Sattelite was successfully destroyed.'
  end

  # GET /sattelites/:id/confirm_delete
  def confirm_delete
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sattelite
    @sattelite = Sattelite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sattelite_params
    params.require(:sattelite).permit(:name, :planet_id, :sattelite_type, :mass, :temperature, :form)
  end
end
