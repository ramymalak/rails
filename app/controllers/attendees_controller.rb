class AttendeesController < ApplicationController
	before_filter :myauth

	  def create
	    @attendee = Attendee.new(attendee_params)
	    @attendee.save
	    @event = Event.find(@attendee.event_id)
	    @group = Group.find(@event.group_id)
		redirect_to group_event_path(@group,@event)
      end

   def destroy
   	@attendee =Attendee.find(params[:id])
   	@event= Event.find(@attendee.event_id)
    @group = Group.find_by(id:  @event.group_id )
    @attendee.destroy
    redirect_to group_event_path(@group,@event)
  end

    def attendee_params
      params.require(:attendee).permit( :user_id , :event_id )
    end

end
