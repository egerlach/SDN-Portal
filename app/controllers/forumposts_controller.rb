class ForumpostsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show, :index ]
  # GET /forumposts
  # GET /forumposts.json
  def index
    @forumposts = Forumpost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forumposts }
    end
  end

  # GET /forumposts/1
  # GET /forumposts/1.json
  def show
    @forumpost = Forumpost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forumpost }
    end
  end

  # GET /forumposts/new
  # GET /forumposts/new.json
  def new
    @forumpost = Forumpost.new

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

    respond_to do |format|
      if @forumpost.save
        format.html { redirect_to @forumpost, notice: 'Forumpost was successfully created.' }
        format.json { render json: @forumpost, status: :created, location: @forumpost }
      else
        format.html { render action: "new" }
        format.json { render json: @forumpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forumposts/1
  # PUT /forumposts/1.json
  def update
    @forumpost = Forumpost.find(params[:id])

    respond_to do |format|
      if @forumpost.update_attributes(params[:forumpost])
        format.html { redirect_to @forumpost, notice: 'Forumpost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forumpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forumposts/1
  # DELETE /forumposts/1.json
  def destroy
    @forumpost = Forumpost.find(params[:id])
    @forumpost.destroy

    respond_to do |format|
      format.html { redirect_to forumposts_url }
      format.json { head :no_content }
    end
  end
end
