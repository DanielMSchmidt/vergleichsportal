class UserSessionsController < ApplicationController
  def new
    @user_new = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        logger.info "User: #{@user.to_s} logged in"
        @active_user = @user
        @user.addCart(@active_cart) unless @user.activeCart.empty? || @active_cart.empty?

        # is true if deleting either the active cart or the users last active cart causes a loss
        @cart_conflict = @user.activeCart.any? && @active_cart.any? && @active_cart.id != @user.activeCart

        format.html { redirect_back_or_to(root_path, :notice => 'Login successful.') }
        format.json { render :json => @user, :status => :created, :location => @user }
        format.js
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
        format.js {render :action => "new"}

      end
    end
  end

  def destroy
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
