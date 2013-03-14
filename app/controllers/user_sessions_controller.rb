class UserSessionsController < ApplicationController
  def new
    @user_new = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(:home, :notice => 'Login successful.') }
        format.json { render :json => @user, :status => :created, :location => @user }
        logger.debug(@user)
        format.js

      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
        logger.debug(@user)
        logger.debug(params)
        format.js {render :action => "new"}

      end
    end
  end

  def destroy
    logout
    redirect_to(root_path, :notice => 'Logged out!')
  end
end
