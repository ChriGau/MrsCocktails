class DosesController < ApplicationController

before_action :set_dose, only: [:show, :edit, :update, :destroy]

   def index
    @doses = Dose.all
  end

  def show

  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    # envoyer à la view la liste des ingrédients définis dans la DB ingrédients
    # @ingredients = Ingredient.all

  end

  # POST /cocktails
  # POST /cocktails.json
  def create
    # create new instance of cocktail because cocktail_id is required
    @cocktail = Cocktail.find(params[:cocktail_id])
    # create new instance of dose thanks to data received via simple_form_for
    # but filter via our dose_params.
    @dose = Dose.new(dose_params)
    # get cocktail_id and assign it to the dose
    @dose.cocktail = @cocktail
    # pour test, ensuite on saisira l'ingredient
    # TODO : assign ingredient_id via form
    @dose.ingredient_id = 3
    @dose.save!

    # respond_to do |format|
    #   if @dose.save!
    #     format.html { redirect_to @dose, notice: 'Dose was successfully created.' }
    #     format.json { render :show, status: :created, location: @dose }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @dose.errors, status: :unprocessable_entity }
    #   end
    # end

    # retour au show du cocktail
    redirect_to cocktail_path(@dose.cocktail_id)
  end

    # GET /cocktails/1/edit
  def edit
  end

  # PATCH/PUT /cocktails/1
  # PATCH/PUT /cocktails/1.json
  def update
    respond_to do |format|
      if @dose.update(dose_params)
        format.html { redirect_to @dose, notice: 'dose was successfully updated.' }
        format.json { render :show, status: :ok, location: @dose }
      else
        format.html { render :edit }
        format.json { render json: @dose.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1
  # DELETE /cocktails/1.json
  def destroy
    @dose.destroy
    respond_to do |format|
      format.html { redirect_to doses_url, notice: 'doses was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dose
      @dose = Dose.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dose_params
      params.require(:dose).permit(:amount, :description, :ingredient_id)
    end
end
