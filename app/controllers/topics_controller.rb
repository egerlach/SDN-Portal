class TopicsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show, :index ]
  before_filter :user_exists?, :except => [ :show, :index ]
  
  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
	@topic.views = @topic.views.to_i + 1
	@topic.save
	@category = @topic.category
	@forum = @category.forum
	@forumposts =  @topic.forumposts.order(:created_at).paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
	@forumpost = Forumpost.new
	@category = params[:category] ? Category.find(params[:category]) : Category.first
	@forum = @category.forum

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
	@category = @topic.category
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
	@topic.user = current_user
	
	#@forumpost = Forumpost.new
	#@forumpost.content = params[:forumpost][:content]
	#@forumpost.user = current_user
	#@forumpost.topic = @topic
    #
    #respond_to do |format|
    #  if @forumpost.save && @topic.save
	#	format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
	#	format.json { render json: @topic, status: :created, location: @topic }
	#  else
	#	if @forumpost.save
	#		@forumpost.destroy
	#		format.html { render action: "new", :category => params[:topic][:category] }
	#		format.json { render json: @topic.errors, status: :unprocessable_entity }
	#	else
	#		@topic.errors[:base] << "The first post must have content."
	#		format.html { render action: "new" }
	#		format.json { render json: @topic.errors, status: :unprocessable_entity }
	#	end
    #  end
    #end
	
	respond_to do |format|
      if @topic.save
		@forumpost = Forumpost.new
		@forumpost.content = params[:forumpost][:content]
		@forumpost.user = current_user
		@forumpost.topic = @topic
		
		if @forumpost.save
			format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
			format.json { render json: @topic, status: :created, location: @topic }
		else
			@topic.destroy
			@topic.errors[:base] << "The first post must have content."
			format.html { render action: "new" }
			format.json { render json: @topic.errors, status: :unprocessable_entity }
		end
	  else
			format.html { render action: "new" }
			format.json { render json: @topic.errors, status: :unprocessable_entity }
	
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])
	if @topic.user == current_user || current_user.admin

		respond_to do |format|
		  if @topic.update_attributes(params[:topic])
			format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @topic.errors, status: :unprocessable_entity }
		  end
		end
	
	else
		redirect_to @topic
	end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
	if @topic.user == current_user || current_user.admin
		@topic.destroy

		respond_to do |format|
		  format.html { redirect_to topics_url }
		  format.json { head :no_content }
		end
	
	else
		redirect_to @topic
	end
  end
end
