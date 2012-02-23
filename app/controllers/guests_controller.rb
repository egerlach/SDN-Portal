class GuestsController < ApplicationController
  # POST /guests
  def create
    @guest = Guest.new(params[:guest])
	if params[:event_id] && Event.find(params[:event_id]).open
		@guest.event_id = params[:event_id]
	end

    respond_to do |format|
      if @guest.save
        format.html { redirect_to event_path(@guest.event_id), notice: 'Guest was successfully added.' }
	    else
        # doing it this way because I am stupid and don't know how to send errors from one Model to another's view
        format.html { redirect_to event_path(@guest.event_id), alert: "Guest was not added. #{
            @guest.errors.full_messages.each do |msg|
              msg
            end
          }" }
      end
    end
  end
end