class HomeController < ApplicationController
	
  def index
  
	# Calendar Info
	@today = params[:month] ? Date.parse(params[:month]) : Date.today
	@month = @today.month
	@year = @today.year
	
	@days_in_month = (Date.new(@year, 12, 31) << (12-@month)).day
	@days = []
	for i in (1..@days_in_month)
		@days << Date.new(@year, @month, i)
	end
	
	@first_day_of_month = @days[0].wday
	@last_day_of_month = @days[@days_in_month-1].wday
	
	@events_in_month = Event.where("start_at >= ? and start_at <= ?", Date.new(@year, @month, 1) - 1.days, Date.new(@year, @month, @days_in_month) + 1.days)
	
	@newses = Newspost.order("updated_at DESC").limit(8)
  
	respond_to do |format|
      format.html # index.html.erb
	  format.json
    end
  end
  
end
