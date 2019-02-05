class DataManagersController < ApplicationController
  layout "data_managers"
  before_action :set_data_manager, only: [:show, :edit, :update, :destroy]

  # GET /data_managers
  # GET /data_managers.json
  def index
    @data_managers = DataManager.all
  end

  # GET /data_managers/1
  # GET /data_managers/1.json
  def show
  end

  # GET /data_managers/new
  def new
    ##@data_manager = DataManager.new
    ##do fucking stuffs
    @dd = DataManager.create(name: "",
                             location: "",
                             gender: "",
                             email: "",
                             birthday: "")
    paramReq = {}
    User.find_each do |user|
      if user.location?
        paramReq[:location] = user.location
      end
      if user.gender?
        paramReq[:gender] = user.gender
      end
      if user.email?
        paramReq[:email] = user.email
      end
      if user.birthday?
        paramReq[:birthday] = user.birthday
      end
      if user.image?
        paramReq[:image] = user.image
      end
      if user.name?
        paramReq[:name] = user.name
      end
      if user.biography?
        paramReq[:biography] = user.biography
      end
      if user.languageSpoken?
        paramReq[:languageSpoken] = user.languageSpoken
      end
      if user.ITlanguages?
        paramReq[:ITlanguages] = user.ITlanguages
      end
      @dd.update(paramReq)
    end
    #User.destroy_all
    redirect_to "/data_managers/#{DataManager.all.count}/edit"
  end

  # GET /data_managers/1/edit
  def edit
  end

  # POST /data_managers
  # POST /data_managers.json
  def create
    @data_manager = DataManager.new(data_manager_params)

    respond_to do |format|
      if @data_manager.save
        format.html { redirect_to @data_manager, notice: 'Data manager was successfully created.' }
        format.json { render :show, status: :created, location: @data_manager }
      else
        format.html { render :new }
        format.json { render json: @data_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_managers/1
  # PATCH/PUT /data_managers/1.json
  def update
    respond_to do |format|
      if @data_manager.update(data_manager_params)
        format.html { redirect_to @data_manager, notice: 'Data manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_manager }
      else
        format.html { render :edit }
        format.json { render json: @data_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_managers/1
  # DELETE /data_managers/1.json
  def destroy
    User.destroy_all
    DataManager.destroy_all
    # @data_manager.destroy
    # respond_to do |format|
    #   format.html { redirect_to data_managers_url, notice: 'Data manager was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    layout "application"
    redirect_to 'template#index'
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_data_manager
    @data_manager = DataManager.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def data_manager_params
    params.require(:data_manager).permit(:name, :location, :gender, :image, :email, :birthday)
  end
end
