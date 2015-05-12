class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:getevents]


  def searchevents_date

  end  
    def getevents

        
        @events = Event.select("events.*, groups.name as n").joins(:group).where("date > ?", params[:date])

        respond_to do |format|
          format.json { render :json => { :data => @events}, :status => 200 }

              #format.json { respond_with_bip(@events)  }
        end
    end


  # GET /events
  # GET /events.json
  def index
    @group = Group.find(params[:group_id])
    @events = Event.where(group_id: params[:group_id])
    @groups = Group.all

  end

  # GET /events/1
  # GET /events/1.json
  def show
  @group = Group.find(params[:group_id])
  @photos = Photo.where(event_id: params[:id])
  @comments = Comment.where(event_id: params[:id])
  @users=User.all
  @attendee = Attendee.find_by(user_id: session[:user_id],event_id: params[:id])
    if(@attendee)
      @flag=1
    else
      @flag=0
    end   


  end

  # GET /events/new
  def new
    @group = Group.find(params[:group_id])
    @events = Event.all
    @event = Event.new
  end

  # GET /events/1/edit
  def edit

     @group = Group.find(params[:group_id])
     @event = Event.find(params[:id])
		
  end

  # POST /events
  # POST /events.json
  def create
    @group = Group.find(params[:group_id])
    @event = Event.new(event_params)
    @event.save
    redirect_to group_events_path(@group)

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
     @event.update(event_params)
     @group = Group.find(params[:group_id])
     redirect_to group_event_path(@group,@event)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @photos = Photo.where(event_id: params[:id])
    @photos.each do |photo|
         photo.destroy
     end  
    @attendees = Attendee.where(event_id: params[:id])  
    @attendees.each do |attendee|
         attendee.destroy
     end  
    @comments = Comment.where(event_id: params[:id])  
    @comments.each do |comment|
         comment.destroy
    end
    @event.destroy
    @group = Group.find(params[:group_id])
    redirect_to group_events_path(@group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :place, :group_id, :description, :date)
    end
end
