class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user

    redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
  end

  def edit
    @user_new = User.new
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]

    not_authenticated unless @user
  end

  def update
    @user_new = User.new
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user

    @user.password_confirmation = params[:user][:password_confirmation]

    respond_to do |format|
      if @user.change_password!(params[:user][:password])

        format.html {redirect_to(root_path, :notice => 'Password was successfully updated.')}
      else
        format.html { render :action => "edit"}
      end
    end
  end
end
