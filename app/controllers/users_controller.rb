class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user_new = User.new(params[:user])

    respond_to do |format|
      if @user_new.valid?
        UsersController.saveOrUpdateUser(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user_new, status: :created, location: @user }
        format.js { render action: "show" }
      else
        format.html { render action: "new" }
        format.json { render json: @user_new.errors, status: :unprocessable_entity }
        format.js {render action: "new"}
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @active_user.update_attributes(params[:user])

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user_id = @user.id
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
      format.js
    end
  end

  def activate
    @user_new = User.new
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def addCart(id = params[:cart_id])
    @active_user.addCart(id)
  end

  def self.saveOrUpdateUser(new_user_params)
    if @active_user
      @active_user.update_attributes(new_user_params)
      @active_user.addRole("Registered User")
      @active_user.removeRole("Guest")
      auto_login(@active_user)
    else
      User.create(new_user_params)
    end
  end
end
