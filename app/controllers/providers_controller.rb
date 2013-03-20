class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.json
  def index
    @providers = Provider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.json
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(params[:provider])
    @provider.active = true

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render json: @provider, status: :created, location: @provider }
      else
        format.html { render action: "new" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.json
  def update
    @provider = Provider.find(params[:id])
    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        @providers = Provider.all
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        logger.debug(@provider)
        format.html { render action: "edit" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_rating
    @provider = Provider.find(params[:id])
    @rating = Rating.new(:value => params[:value],:user_id => @active_user.id, :provider_id => @provider.id)
    @rating.save
    @provider.ratings << @rating
    @provider.save
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Danke fuer die Bewertung"}
      format.json { render json: @rating }
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url }
      format.json { head :no_content }
    end
  end

  def add_provider
    name = params[:name]
    #send mail
  end
end
