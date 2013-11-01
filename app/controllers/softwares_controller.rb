class SoftwaresController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy, :history]

  # GET /softwares
  # GET /softwares.json
  def index
    @parent_path = root_path
    @page_title = t 'v.softwares.all'
    @softwares = Software.find(:all, :order => 'title')
  end

  # GET /softwares/1
  # GET /softwares/1.json
  def show
    if @software.categories.first != nil
      @subcategories = @software.categories.first.root.leaves
      @category = (@subcategories & @software.categories).first
    end
    @parent_path = @category
  end

  # GET /softwares/new
  def new
    @parent_path = softwares_path
    @page_title = t 'v.softwares.new'
    @software = Software.new
    @categories = Category.all
  end

  # GET /softwares/1/edit
  def edit
    @parent_path = @software
    @page_title = t 'v.softwares.edit'
  end

  # POST /softwares
  # POST /softwares.json
  def create
    @software = Software.new(software_params)
    @software.attributes = {'category_ids' => []}.merge(params[:software] || {})
    @software.attributes = {'protocol_ids' => []}.merge(params[:software] || {})
    @software.attributes = {'operating_system_ids' => []}.merge(params[:software] || {})

    respond_to do |format|
      if @software.save
        @software.update_description
        format.html { redirect_to @software, notice: 'Software was successfully created.' }
        format.json { render action: 'show', status: :created, location: @software }
      else
        format.html { render action: 'new' }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /softwares/1
  # PATCH/PUT /softwares/1.json
  def update
    @software.attributes = {'category_ids' => []}.merge(params[:software] || {})
    @software.attributes = {'protocol_ids' => []}.merge(params[:software] || {})
    @software.attributes = {'operating_system_ids' => []}.merge(params[:software] || {})
    respond_to do |format|
      if @software.update(software_params)
        @software.update_description
        format.html { redirect_to @software, notice: 'Software was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /softwares/1
  # DELETE /softwares/1.json
  def destroy
    @software.destroy
    respond_to do |format|
      format.html { redirect_to softwares_url }
      format.json { head :no_content }
    end
  end

  def history
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def software_params
      params.require(:software).permit(:title, :description, :url, :source_url, :privacy_url, :tos_url, :category_ids, :logo)
    end
end
