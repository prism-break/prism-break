class OperatingSystemsController < ApplicationController
  before_action :set_operating_system, only: [:show, :edit, :update, :destroy]

  # GET /operating_systems
  # GET /operating_systems.json
  def index
    @parent_path = root_path
    @page_title = t 'operating-systems'
    @operating_systems = OperatingSystem.find(:all, :order => 'title')
  end

  # GET /operating_systems/1
  # GET /operating_systems/1.json
  def show
    @parent_path = operating_systems_path
  end

  # GET /operating_systems/new
  def new
    @operating_system = OperatingSystem.new
  end

  # GET /operating_systems/1/edit
  def edit
  end

  # POST /operating_systems
  # POST /operating_systems.json
  def create
    @operating_system = OperatingSystem.new(operating_system_params)

    respond_to do |format|
      if @operating_system.save
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operating_system }
      else
        format.html { render action: 'new' }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operating_systems/1
  # PATCH/PUT /operating_systems/1.json
  def update
    respond_to do |format|
      if @operating_system.update(operating_system_params)
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operating_systems/1
  # DELETE /operating_systems/1.json
  def destroy
    @operating_system.destroy
    respond_to do |format|
      format.html { redirect_to operating_systems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operating_system
      @operating_system = OperatingSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operating_system_params
      params.require(:operating_system).permit(:title, :description, :url)
    end
end
