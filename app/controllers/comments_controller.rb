class CommentsController < ApplicationController
  before_filter :myauth
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  @group = Group.find(params[:group_id])
  @event = Event.find(params[:event_id])
  @photos = Photo.where(event_id: params[:event_id])
  @comments = Comment.where(event_id: params[:event_id])
  @comment = Comment.find(params[:id])
  @users=User.all
  end

  # POST /comments
  # POST /comments.json
  def create
  
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to group_event_path(@group,@event)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @comment.update(comment_params)
     redirect_to group_event_path(@group,@event)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    redirect_to group_event_path(@group,@event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id , :event_id )
    end
end
