class PlatformTypesController < ApplicationController
  before_action :set_platform_type, only: [:show, :edit, :update, :destroy]

  # GET /platform_types
  # GET /platform_types.json
  def index
    @platform_types = PlatformType.all
    @parent_path = root_path
    @page_title = t 'v.platform_types.plural'
  end

  # GET /platform_types/1
  # GET /platform_types/1.json
  def show
    @parent_path = platform_types_path
    @page_title = @platform_type.title
  end

  # GET /platform_types/new
  def new
    @platform_type = PlatformType.new
  end

  # GET /platform_types/1/edit
  def edit
    @parent_path = @platform_type
    @page_title =  t 'v.platform_types.edit'
  end

  # POST /platform_types
  # POST /platform_types.json
  def create
    @platform_type = PlatformType.new(platform_type_params)

    respond_to do |format|
      if @platform_type.save
        format.html { redirect_to @platform_type, notice: 'Platform type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @platform_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @platform_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platform_types/1
  # PATCH/PUT /platform_types/1.json
  def update
    respond_to do |format|
      if @platform_type.update(platform_type_params)
        format.html { redirect_to @platform_type, notice: 'Platform type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @platform_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platform_types/1
  # DELETE /platform_types/1.json
  def destroy
    @platform_type.destroy
    respond_to do |format|
      format.html { redirect_to platform_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform_type
      @platform_type = PlatformType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_type_params
      params.require(:platform_type).permit(:title)
    end
end
