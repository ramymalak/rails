class AttendeesController < ApplicationController

	  def create
	    @attendee = Attendee.new(attendee_params)
	    @attendee.save
	    @event = Event.find(@attendee.event_id)
	    @group = Group.find(@event.group_id)
		redirect_to group_event_path(@group,@event)
      end

    def attendee_params
      params.require(:attendee).permit( :user_id , :event_id )
    end
end
