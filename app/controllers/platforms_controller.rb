class PlatformsController < ApplicationController
  before_action :set_platform, only: [:show, :edit, :update, :destroy]

  # GET /platforms
  # GET /platforms.json
  def index
    @parent_path = root_path
    @page_title = t 'v.platforms.plural'
    @platforms = Platform.all
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
    @parent_path = root_path
    @page_title = @platform.title
  end

  # GET /platforms/new
  def new
    @parent_path = platforms_path
    @page_title = t 'v.platforms.new'
    @platform = Platform.new
  end

  # GET /platforms/1/edit
  def edit
    @parent_path = @platform
    @page_title = t 'v.platforms.edit'
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(platform_params)

    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
        format.json { render action: 'show', status: :created, location: @platform }
      else
        format.html { render action: 'new' }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platforms/1
  # PATCH/PUT /platforms/1.json
  def update
    respond_to do |format|
      if @platform.update(platform_params)
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform.destroy
    respond_to do |format|
      format.html { redirect_to platforms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @platform = Platform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_params
      params.require(:platform).permit(:title, :description, :wikipedia_url)
    end
end
