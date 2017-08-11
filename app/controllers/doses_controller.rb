class DosesController < ApplicationController
   def index
    @doses = Dose.all
  end

  def show
    # instancier @doses = array qui contient des entités doses rattachées au cocktail
  end

  def new
    @dose = Dose.new
    # envoyer à la view la liste des ingrédients définis dans la DB ingrédients
    @ingredients = Ingredient.all
    redirect_to cocktail_path
  end

  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails
  # POST /cocktails.json
  def create
    @dose = Dose.new(dose_params)


    respond_to do |format|
      if @dose.save!
        format.html { redirect_to @dose, notice: 'Dose was successfully created.' }
        format.json { render :show, status: :created, location: @dose}
      else
        format.html { render :new }
        format.json { render json: @dose.errors, status: :unprocessable_entity }
      end
    end
    # envoyer à la view le cocktail pour le lien "go back to cocktail"
    @cocktail = Cocktail.find(@dose)
    redirect_to new_cocktail_dose_path(@dose.cocktail_id)
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
      params.require(:dose).permit(:amount, :description)
    end
end
