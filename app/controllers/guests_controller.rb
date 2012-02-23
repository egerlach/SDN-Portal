class GuestsController < ApplicationController
  # POST /guests
  def create
    event = params[:guest][:event_id] ? Event.find(params[:guest][:event_id]) : false
    if event && event.open && (!event.slots || (event.slots > event.guests.count)) 
      
      @guest = Guest.new(params[:guest])

      respond_to do |format|
        if @guest.save
          format.html { redirect_to event_path(@guest.event_id), notice: 'Guest was successfully added.' }
        else
          # doing it this way because I am stupid and don't know how to send  errors from one Model to another's view
          format.html { redirect_to event_path(@guest.event_id), alert: "Guest  was not added. #{
              @guest.errors.full_messages.each do |msg|
                msg
              end
            }" }
        end
      end
    else
      redirect_to events_path
    end
  end
end