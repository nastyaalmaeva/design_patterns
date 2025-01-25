class PlanetsController < ApplicationController
  before_action :set_planet, only: [:show, :edit, :update, :destroy, :confirm_delete]

  # GET /planets
  def index
    @planets = Planet.all
  end

  # GET /planets/:id
  def show
  end

  # GET /planets/new
  def new
    @planet = Planet.new
  end

  # GET /planets/:id/edit
  def edit
  end

  # POST /planets
  def create
    @planet = Planet.new(planet_params)
    if @planet.save
      redirect_to @planet, notice: 'Planet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /planets/:id
  def update
    if @planet.update(planet_params)
      redirect_to @planet, notice: 'Planet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /planets/:id
  def destroy
    if @planet.sattelites.any?
      redirect_to planets_path, alert: 'Cannot delete planet with associated sattelites.'
    else
      @planet.destroy
      redirect_to planets_path, notice: 'Planet was successfully destroyed.'
    end
  end

  # GET /planets/:id/confirm_delete
  def confirm_delete
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_planet
    @planet = Planet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def planet_params
    params.require(:planet).permit(:name, :star_id, :planet_type, :mass, :temperature)
  end
end
