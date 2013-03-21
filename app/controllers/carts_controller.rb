class CartsController < ApplicationController

  # POST /carts
  # POST /carts.json
  def create
    @active_cart = Cart.new(params[:cart])

    respond_to do |format|
      if @active_cart.save
        set_cart_providers
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
        @active_cart = Cart.find(@active_cart.id)
        set_cart_providers
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
        @active_cart = Cart.find(@active_cart.id)
        set_cart_providers
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
    set_cart_providers
    respond_to :js
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @active_cart = Cart.find(params[:id])
    @cart_id = @active_cart.id
    @active_cart.destroy
    set_active_cart
    set_cart_providers
    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
      format.js
    end
  end

  def add_new
    Rails.logger.info "CartsController#add_new called, adding new cart to active user"
    empty_cart = @active_user.get_empty_cart
    if empty_cart
      @active_cart = Cart.find(empty_cart.id)
      set_cart_providers
      redirect_to use_cart_path(empty_cart.id)
    else
      new_cart = @active_user.carts.create!
      cookies[:active_cart] = new_cart.id
      @active_cart = Cart.find(new_cart.id)
      set_cart_providers
      respond_to :js
    end
  end
end
