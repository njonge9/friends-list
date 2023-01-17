class FamiliesController < ApplicationController
  before_action :set_family, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /families or /families.json
  def index
    @families = Family.all
  end

  # GET /families/1 or /families/1.json
  def show
  end

  # GET /families/new
  def new
    # @family = Family.new
    @family = current_user.families.build
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families or /families.json
  def create
    # @family = Family.new(family_params)
    @family  = current_user.families.build(family_params)

    respond_to do |format|
      if @family.save
        format.html { redirect_to family_url(@family), notice: "Family was successfully created." }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1 or /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to family_url(@family), notice: "Family was successfully updated." }
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1 or /families/1.json
  def destroy
    @family.destroy

    respond_to do |format|
      format.html { redirect_to families_url, notice: "Family was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @family = current_user.families.find_by(id: params[:id])
    redirect_to families_path, notice: "Not authorized to edit this friend" if @friend.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def family_params
      params.require(:family).permit(:first_name, :last_name, :email, :phone, :twitter,:user_id)
    end
end
