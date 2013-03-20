class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @active_cart = Cart.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @active_cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @active_cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @active_cart = Cart.new(params[:cart])

    respond_to do |format|
      if @active_cart.save
        format.html { redirect_to @active_cart, notice: 'Cart was successfully created.' }
        format.json { render json: @active_cart, status: :created, location: @active_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @active_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @active_cart = Cart.find(params[:id])

    respond_to do |format|
      if @active_cart.update_attributes(params[:cart])
        format.html { redirect_to @active_cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @active_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /carts/1/add/1
  # GET /carts/1/add/1.json
  def add_article
    article = Article.find(params[:article_id])

    respond_to do |format|
      if @active_cart.add_article(article)
	      format.html { redirect_to @active_cart, notice: 'Article was successfully added.' }
	      format.json { head :no_contest }
        format.js
      else
	      format.html { redirect_to @active_cart, notice: 'An error occured while adding the Article.' }
	      format.json { render json: @active_cart.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /carts/1/remove/1
  # GET /carts/1/remove/1.json
  def remove_article
    article = Article.find(params[:article_id])

    respond_to do |format|
      if @active_cart.remove_article(article)
	      format.html { redirect_to @active_cart, notice: 'Article was successfully removed.' }
	      format.json { head :no_contest }
        format.js
      else
	      format.html { redirect_to @active_cart, notice: 'An error occured while adding the Article.' }
	      format.json { render json: @active_cart.errors, status: :unprocessable_entity }
      end
    end
  end


  #GET /carts/1/use
  def use
    new_cart = Cart.find(params[:id])
    @active_cart = new_cart
    respond_to :js
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @active_cart = Cart.find(params[:id])
    @active_cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
end
