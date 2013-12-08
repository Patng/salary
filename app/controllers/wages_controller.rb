class WagesController < ApplicationController
  before_action :set_wage, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:show, :search]

  # GET /wages
  # GET /wages.json
  def index
    @wages = Wage.order("created_at desc").page(params[:page]).per_page(20)
  end

  def import
    Wage.import(params[:file])
    redirect_to wages_path, notice: "Wages imported."
  end

  def search
    title = params[:title]
    company = params[:company]
    location_id = params[:location_id]
    page = params[:page]
    @wages = Wage.search(title, company, location_id,page)
  end

  # GET /wages/1
  # GET /wages/1.json
  def show
  end

  # GET /wages/new
  def new
    @wage = Wage.new
  end

  # GET /wages/1/edit
  def edit
  end

  # POST /wages
  # POST /wages.json
  def create
    @wage = Wage.new(wage_params)

    respond_to do |format|
      if @wage.save
        format.html { redirect_to @wage, notice: 'Wage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wage }
      else
        format.html { render action: 'new' }
        format.json { render json: @wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wages/1
  # PATCH/PUT /wages/1.json
  def update
    respond_to do |format|
      if @wage.update(wage_params)
        format.html { redirect_to @wage, notice: 'Wage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wages/1
  # DELETE /wages/1.json
  def destroy
    @wage.destroy
    respond_to do |format|
      format.html { redirect_to wages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wage
      @wage = Wage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wage_params
      params.require(:wage).permit(:title, :company, :location_id, :total, :avg, :high, :low)
    end
end
