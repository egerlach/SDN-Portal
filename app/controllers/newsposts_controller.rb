class NewspostsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show, :index ]
  before_filter :user_exists?, :except => [ :show, :index ]
  
  # TODO: ARCHIVES!!
  
  # GET /newsposts
  # GET /newsposts.json
  def index
	@newsposts = Newspost.all

	respond_to do |format|
		format.html # index.html.erb
		format.json { render json: @newsposts }
	end
  end

  # GET /newsposts/1
  # GET /newsposts/1.json
  def show
    @newspost = Newspost.find(params[:id])
	@comment = Comment.new
	@comments = Comment.where(:newspost_id => params[:id]).order(:created_at)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @newspost }
    end
  end

  # GET /newsposts/new
  # GET /newsposts/new.json
  def new
	@newspost = Newspost.new

	respond_to do |format|
	  format.html # new.html.erb
	  format.json { render json: @newspost }
	end
  end

  # GET /newsposts/1/edit
  def edit
	curr_user = current_user
    newspost = Newspost.find(params[:id])
	
	if curr_user.admin || newspost.user_id == curr_user.id
		@newspost = newspost
	else
		redirect_to newspost_path(newspost)
	end
  end

  # POST /newsposts
  # POST /newsposts.json
  def create
    @newspost = Newspost.new(params[:newspost])
	curr_user = current_user
	@newspost.user_id = curr_user.id

	if params[:tags]
		post_tags = params[:tags].gsub(/\s+/, "").split(',')
		post_tags.each do |t|
			tag = Tag.where(:name => t)
			if tag.empty?
				tag = Tag.create(:name => t)
			end
			@newspost.tags << tag
		end
	end

	respond_to do |format|
	  if @newspost.save
		format.html { redirect_to @newspost, notice: 'Newspost was successfully created.' }
		format.json { render json: @newspost, status: :created, location: @newspost }
	  else
		format.html { render action: "new" }
		format.json { render json: @newspost.errors, status: :unprocessable_entity }
	  end
	end
  end

  # PUT /newsposts/1
  # PUT /newsposts/1.json
  def update
    @newspost = Newspost.find(params[:id])
	curr_user = current_user
	
	if @newspost.user == curr_user || curr_user.admin 

		respond_to do |format|
		  if @newspost.update_attributes(params[:newspost])
			format.html { redirect_to @newspost, notice: 'Newspost was successfully updated.' }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @newspost.errors, status: :unprocessable_entity }
		  end
		end
		
	else
		redirect_to newspost_path(@newspost)
	end
  end

  # DELETE /newsposts/1
  # DELETE /newsposts/1.json
  def destroy
    @newspost = Newspost.find(params[:id])
	curr_user = current_user
	
	if @newspost.user == curr_user || curr_user.admin 
		@newspost.destroy

		respond_to do |format|
		  format.html { redirect_to newsposts_url }
		  format.json { head :no_content }
		end
		
	else
		redirect_to newspost_path(@newspost)
	end
  end
end
