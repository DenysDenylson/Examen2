class ThermostatsController < ApplicationController
  before_filter :authenticate_user!, :except =>  [:index]
  before_action :set_thermostat, only: [:show, :edit, :update, :destroy]
   #load_and_authorize_resource
   #authorize_resource
   #load_and_authorize_resource :through => :current_user
  # GET /thermostats
  # GET /thermostats.json

  def change_role
    @user=User.find(params[:id])

    if @user.role=="admin"
      @user.role="simple"
    else
      @user.role="admin"
    end
    @user.save
    redirect_to '/'
  end

  def index
    if user_signed_in? && current_user.role == 'admin'
      redirect_to '/admi'
      @thermostats=Thermostat.all
    else
    if  user_signed_in?
       redirect_to '/home'
    end
  end
  end

   def home
    if current_user.role != 'admin' 
    @thermostats = Thermostat.all
    else
     redirect_to '/'
   end
   end
 
   def admi
    if current_user.role != 'simple'
    @users= User.all
    @thermostats = Thermostat.all
  else
    redirect_to '/'
  end

   end

  # GET /thermostats/1
  # GET /thermostats/1.json
  def show
  end

  def history
    redirect_to show_history
  end

  def block
  end

  def unlock
  end

  # GET /thermostats/new
  def new
    @thermostat = Thermostat.new
  end

  # GET /thermostats/1/edit
  def edit
  end

  # POST /thermostats
  # POST /thermostats.json
  def create
    @thermostat = Thermostat.new(thermostat_params)
   @thermostat.user_id=current_user.id
    @thermostat.energy = 0
    respond_to do |format|
      if @thermostat.save
        @thermostat.history_thermostats.create(temperature:@thermostat.temperature, humidity: @thermostat.humidity, energy: @thermostat.energy)
        format.html { redirect_to @thermostat, notice: 'Thermostat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @thermostat }
      else
        format.html { render action: 'new' }
        format.json { render json: @thermostat.errors, status: :unprocessable_entity }
      end
    end
  end

  def add
    @thermostat = Thermostat.find(params[:id])
    @thermostat.temperature = @thermostat.temperature + 1
    @thermostat.history_thermostats.create(temperature:@thermostat.temperature, humidity: @thermostat.humidity, energy: @thermostat.energy)
    @thermostat.save
    redirect_to :back
  end

  def sub
    @thermostat = Thermostat.find(params[:id])
    @thermostat.temperature = @thermostat.temperature - 1
    @thermostat.history_thermostats.create(temperature:@thermostat.temperature, humidity: @thermostat.humidity, energy: @thermostat.energy)
    @thermostat.save
    redirect_to :back
  end


  # PATCH/PUT /thermostats/1
  # PATCH/PUT /thermostats/1.json
  def update
    respond_to do |format|
      if @thermostat.update(thermostat_params)
        @thermostat.history_thermostats.create(temperature:@thermostat.temperature, humidity: @thermostat.humidity, energy: @thermostat.energy)
        format.html { redirect_to @thermostat, notice: 'Thermostat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @thermostat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thermostats/1
  # DELETE /thermostats/1.json
  def destroy
    @thermostat.destroy
    respond_to do |format|
      format.html { redirect_to thermostats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thermostat
      @thermostat = Thermostat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thermostat_params
      params.require(:thermostat).permit(:serial, :temperature, :humidity, :energy, :user_id)
    end
end
