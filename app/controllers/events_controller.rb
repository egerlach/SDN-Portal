class EventsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :show ]
  before_filter :user_exists?, :except => [ :show ]
  
  # Sees if the current user has permissions for this event
  def owns_event_or_admin? event, curr_user
	curr_user && event.user_id == curr_user.id || curr_user.admin
  end
  
  # GET /events
  # GET /events.json
  def index
	@events = Event.all
	@curr_user = current_user
	
	if !is_admin?
		redirect_to root_path
	else

		respond_to do |format|
		format.html # index.html.erb
		format.json { render json: @events }
		end

	end
  end

  # GET /events/1
  # GET /events/1.json
  def show
	@events = Event.order(:start_at)
	@curr_user = current_user
	
	if @events.empty? && logged_in?
		redirect_to new_event_path
	elsif @events.empty?
		redirect_to root_path
	else
	
		@event_index = @events.index{|ev| ev.id.to_s == params[:id]}
		@event = Event.find(params[:id])
		@guest = Guest.new
		
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @event }
		end
	
	end
  end

  # GET /events/new
  # GET /events/new.json
  def new
	@event = Event.new
	@curr_user = current_user
	
	respond_to do |format|
		format.html # new.html.erb
		format.json { render json: @event }
	end
  end

  # GET /events/1/edit
  def edit
    event = Event.find(params[:id])
	@curr_user = current_user
	if owns_event_or_admin? event
		@event = event
	else
		redirect_to event_path(event)
	end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
	@event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    event = Event.find(params[:id])
	if owns_event_or_admin? event, current_user
		@event = event

		respond_to do |format|
			if @event.update_attributes(params[:event])
				format.html { redirect_to @event, notice: 'Event was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	else
		redirect_to event_path(event)
	end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    event = Event.find(params[:id])
	if owns_event_or_admin? event, current_user
		@event = event
		@event.destroy
	
		respond_to do |format|
			format.html { redirect_to events_url }
			format.json { head :no_content }
		end
	else
		redirect_to event_path(event)
	end
  end
end
