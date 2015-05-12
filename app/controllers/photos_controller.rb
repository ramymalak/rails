class PhotosController < ApplicationController
	before_filter :myauth
	
	def new
	@group = Group.find(params[:group_id])
	@event = Event.find(params[:event_id])
	end
	
	def create
	  @photo = Photo.create(photo_params)
      @group = Group.find(params[:group_id])
      @event = Event.find(params[:event_id]) 
	  #redirect_to group_event_photo_path(@group,@event,@photo)
	  redirect_to group_event_path(@group,@event)
	end

	 def show
 	  @group = Group.find(params[:group_id])
      @event = Event.find(params[:event_id]) 
	  @photo = Photo.find(params[:id])
	 end

	def photo_params
	  params.require(:photo).permit(:avatar, :event_id)
	end
end
