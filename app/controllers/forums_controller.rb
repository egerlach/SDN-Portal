class ForumsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show, :index ]
  before_filter :user_exists?, :except => [ :show, :index ]
  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @forum = Forum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
	if current_user.admin
		@forum = Forum.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @forum }
		end
	else
		redirect_to forums_path
	end
  end

  # GET /forums/1/edit
  def edit
	if current_user.admin
		@forum = Forum.find(params[:id])
	else
		redirect_to forums_path
	end
  end

  # POST /forums
  # POST /forums.json
  def create
	if current_user.admin
		@forum = Forum.new(params[:forum])

		respond_to do |format|
		  if @forum.save
			format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
			format.json { render json: @forum, status: :created, location: @forum }
		  else
			format.html { render action: "new" }
			format.json { render json: @forum.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to @forum
	end
  end

  # PUT /forums/1
  # PUT /forums/1.json
  def update
	@forum = Forum.find(params[:id])
	if current_user.admin

		respond_to do |format|
		  if @forum.update_attributes(params[:forum])
			format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @forum.errors, status: :unprocessable_entity }
		  end
		end
	else
		redirect_to @forum
	end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
	if current_user.admin
		@forum = Forum.find(params[:id])
		@forum.destroy

		respond_to do |format|
		  format.html { redirect_to forums_url }
		  format.json { head :no_content }
		end
	else
		redirect_to @forum
	end
  end
end
