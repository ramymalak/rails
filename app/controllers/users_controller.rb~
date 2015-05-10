class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end



def login

end


def auth  

  if (params[:email]=='' || params[:password]=='')
    redirect_to log_in_path, :notice => "Email or password can not be null"

  else

    user = User.authenticate(params[:email], params[:password])
    if (user)
        if ( user.isConf )
          session[:user_id] = user.id
          session[:user_username] = user.username
          session[:user_isAdmin] = user.isAdmin
          session[:user_isConf] = user.isConf

          redirect_to groups_path, :notice => "Logged in!"
        
        else
          @user = user
          render :not_confirmed
        end

    else

      redirect_to log_in_path, :notice => "Invalid email or password"
    end
  end
end




def logout
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end








  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save

        #if a normal user os signing up, send a confirmation email
        if (!current_user )
            UserNotifier.send_signup_email(@user).deliver!
            format.html { render :confirmation_process }
        end



        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def confirmation

 end


  def confirmation_pro


    @user = User.confirmation(params[:id], params[:password])
    if (@user ) 
     
      if  @user.update_attribute('isConf',1)
      
        redirect_to log_in_path, :notice => "Confirmation completed!, you can now log in."
        return
      end
             
    end
    redirect_to confirmation_path(params[:id]) , :notice => "Invalid password!"

  end



  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :age, :gender, :country_id, :city_id, :isAdmin, :isConf)
    end
end
