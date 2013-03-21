class UserSessionsController < ApplicationController
  def new
    @user_new = User.new
  end

  def create
    respond_to do |format|
      if !@user.active && @user = login(params[:username],params[:password])
        logger.info "User: #{@user.to_s} logged in"
        @active_user = @user
        @user.addCart(@active_cart) unless @active_cart.empty?

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
