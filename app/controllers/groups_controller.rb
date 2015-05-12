class GroupsController < ApplicationController
  before_filter :myauth

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @users = User.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @interests = Interest.where(group_id: params[:id])
    @tags=Tag.all
  end

  # GET /groups/new
  def new
    @tags = Tag.all
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    newparam= checker()
    @group = Group.new(newparam)
    @data=(params['group']['lol']).split(':')
    respond_to do |format|
      if @group.save
        @data.each do |x|
          if (x!="")
            @i = Interest.create(group_id: @group.id, tag_id: x)
          end
        end  
        format.html { redirect_to @group, notice: params['group']['lol']}
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    newparam= checker()
    respond_to do |format|
      if @group.update(newparam)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    
    @events = Event.where(group_id: params[:id])
    @events.each do |event|
         
        @photos = Photo.where(event_id: event.id)
        @photos.each do |photo|
             photo.destroy
         end  
        @attendees = Attendee.where(event_id: event.id)  
        @attendees.each do |attendee|
             attendee.destroy
         end  
        @comments = Comment.where(event_id: event.id)  
        @comments.each do |comment|
             comment.destroy
        end

         event.destroy
     end
     @interests = Interest.where(group_id: params[:id])  
     @interests.each do |interest|
          interest.destroy
     end
     @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end
    def checker
      theparam=[];
      theparam=group_params();
      thelong=group_params[:long]
      thelat=group_params[:lat]
      if(thelong=='non' || thelat=='non')
        thecith=group_params[:hometown].split(',',2)[0];
        thecoun=group_params[:hometown].split(',',2)[1].split(' ',2)[0];
        theconid=Country.find_by('name = ?',thecoun).id;
        puts City.where('name = ? and country_id = ?',thecith,theconid).inspect
        thelat=City.where('name = ? and country_id = ?',thecith,theconid)[0].lat
        thelong=City.where('name = ? and country_id = ?',thecith,theconid)[0].long
        puts thelat.inspect
        puts thelong.inspect
        theparam[:long]=thelong;
        theparam[:lat]=thelat;
        puts thelong.inspect
      end
      return theparam
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name,:long ,:lat , :description, :user_id,:hometown)
    end
end
