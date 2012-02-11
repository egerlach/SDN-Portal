class UsersController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  
  # GET /users
  # GET /users.json
  def index
	if is_admin?
		@users = User.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @users }
		end
	else
		redirect_to root_path
	end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id] == "self" 
		@user = User.find(current_user.id)
	else
		@user = User.find(params[:id])
	end

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
    user = User.find(params[:id])
	if current_user == user || is_admin?
		@user = user
	else
		redirect_to user_path("self")
	end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
	@user.userid = session[:cas_user]

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    user = User.find(params[:id])
	if current_user == user || is_admin?
	
		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to @user, notice: 'User was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	
	else
		redirect_to user_path("self")
	end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
	if is_admin?
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end
  end
end
