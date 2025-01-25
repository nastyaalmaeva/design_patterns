class StarsController < ApplicationController
  before_action :set_star, only: [:show, :edit, :update, :destroy, :confirm_delete]

  # GET /stars
  def index
    @stars = Star.all
  end

  # GET /stars/:id
  def show
  end

  # GET /stars/new
  def new
    @star = Star.new
  end

  # GET /stars/:id/edit
  def edit
  end

  # POST /stars
  def create
    @star = Star.new(star_params)
    if @star.save
      redirect_to @star, notice: 'Star was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stars/:id
  def update
    if @star.update(star_params)
      redirect_to @star, notice: 'Star was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /stars/:id
  def destroy
    if @star.planets.any?
      redirect_to stars_path, alert: 'Cannot delete star with associated planets.'
    else
      @star.destroy
      redirect_to stars_path, notice: 'Star was successfully destroyed.'
    end
  end

  # GET /stars/:id/confirm_delete
  def confirm_delete
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_star
    @star = Star.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def star_params
    params.require(:star).permit(:name, :spectral_class, :temperature, :mass, :color)
  end
end
