class AdvertismentsController < ApplicationController
  # GET /advertisments
  # GET /advertisments.json
  def index
    @advertisments = Advertisment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertisments }
    end
  end

  # GET /advertisments/1
  # GET /advertisments/1.json
  def show
    @advertisment = Advertisment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertisment }
      format.js
    end
  end

  # GET /advertisments/new
  # GET /advertisments/new.json
  def new
    @advertisment = Advertisment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisment }
    end
  end

  # GET /advertisments/1/edit
  def edit
    @advertisment = Advertisment.find(params[:id])
  end

  # POST /advertisments
  # POST /advertisments.json
  def create
    @advertisment = Advertisment.new(params[:advertisment])

    respond_to do |format|
      if @advertisment.save
        format.html { redirect_to @advertisment, notice: 'Advertisment was successfully created.' }
        format.json { render json: @advertisment, status: :created, location: @advertisment }
        format.js { render action: "show", notice: 'Advertisment was successfully created.'}
      else
        format.html { render action: "new" }
        format.json { render json: @advertisment.errors, status: :unprocessable_entity }
        format.js {render action: "new"}
      end
    end
  end

  # PUT /advertisments/1
  # PUT /advertisments/1.json
  def update
    @advertisment = Advertisment.find(params[:id])

    logger.debug "update #{@advertisment}"
    respond_to do |format|
      if @advertisment.update_attributes(params[:advertisment])
        format.html { redirect_to @advertisment, notice: 'Advertisment was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisment.errors, status: :unprocessable_entity }
        format.js { render action: "edit"}
      end
    end
  end

  #PUT /advertisment/1/activate
  #PUT /advertisment/1/activate.json
  def activate
    advertisment = Advertisment.find(params[:id])
    unless advertisment.nil?
      advertisment.activate
      @active_advertisment = advertisment
    end
    respond_to do |format|
      format.html { redirect_to admin_home_path }
      format.json { head :no_content }
    end
  end
  # DELETE /advertisments/1
  # DELETE /advertisments/1.json
  def destroy
    @advertisment = Advertisment.find(params[:id])
    @ad_id = @advertisment.id
    logger.debug "delete #{@advertisment}"
    @advertisment.destroy
    respond_to do |format|
      format.html { redirect_to advertisments_url }
      format.json { head :no_content }
      format.js
    end
  end
end
