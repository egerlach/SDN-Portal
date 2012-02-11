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
		format.html { redirect_to event_path(@guest.event_id), notice: 'Guest was errored.' }
      end
    end
  end
end