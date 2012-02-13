class ForumpostsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show, :index ]
  before_filter :user_exists?, :except => [ :show, :index ]

  # GET /forumposts/1
  # GET /forumposts/1.json
  def show
    @forumpost = Forumpost.find(params[:id])
	@topic = params[:topic] ? Topic.find(params[:topic]) : Topic.first
	@category = @topic.category
	@forum = @category.forum

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forumpost }
    end
  end

  # GET /forumposts/new
  # GET /forumposts/new.json
  def new
    @forumpost = Forumpost.new
	@topic = params[:topic] ? Topic.find(params[:topic]) : Topic.first
	@category = @topic.category
	@forum = @category.forum

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forumpost }
    end
  end

  # GET /forumposts/1/edit
  def edit
    @forumpost = Forumpost.find(params[:id])
  end

  # POST /forumposts
  # POST /forumposts.json
  def create
    @forumpost = Forumpost.new(params[:forumpost])
	@forumpost.user = current_user

    respond_to do |format|
      if @forumpost.save
        format.html { redirect_to @forumpost.topic, notice: 'Forumpost was successfully created.' }
        format.json { render json: @forumpost.topic, status: :created, location: @forumpost.topic }
      else
        format.html { render action: "new" }
        format.json { render json: @forumpost.topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forumposts/1
  # PUT /forumposts/1.json
  def update
    @forumpost = Forumpost.find(params[:id])
	if @forumpost.user == current_user || current_user.admin

		respond_to do |format|
		  if @forumpost.update_attributes(params[:forumpost])
			format.html { redirect_to @forumpost.topic, notice: 'Forumpost was successfully updated.' }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @forumpost.topic.errors, status: :unprocessable_entity }
		  end
		end
	
	else
		redirect_to @forumpost
	end
  end

  # DELETE /forumposts/1
  # DELETE /forumposts/1.json
  def destroy
    @forumpost = Forumpost.find(params[:id])
	@topic = @forumpost.topic
	if @forumpost.user == current_user || current_user.admin
		@forumpost.destroy

		respond_to do |format|
		  format.html { redirect_to @topic }
		  format.json { head :no_content }
		end
	
	else
		redirect_to @forumpost
	end
  end
end
