class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  #before_filter :myauth

  # GET /users
  # GET /users.json
  def index


    # if ( !current_user  || !current_user.isAdmin )
    #   render :text => "You are not authorized to see this page", :layout => true
    #
    #   return
    # end

    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end



def login

          if (current_user)
            redirect_to groups_path
          end

end


def auth  

  if (params[:email]=='' || params[:password]=='')
    redirect_to log_in_path, :notice => "Email or password can not be null"

  else

    user = User.authenticate(params[:email], params[:password])
    if (user)
        if ( user.isConf  ||  user.isAdmin )  #admin or configured normal user
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
    id = params[:id]
  end



  def chngpass


  end



  def chngpass_pro

    notification = ' ' 
    flag = false
    #oldPass = User.select("password").where("id = ?", session[:user_id])
    @user = User.confirmation(session[:user_id], params[:oldpassword])




      if (!@user)
        notification = "Current password is wrong\n" 
        flag = true
      end
      if (params[:password] != params[:password_conf] )
        notification = notification.to_s + " New password and its reply don't match!\n"
        flag = true
      end

      if flag
        redirect_to chng_pass_path, :notice => notification
        return    
      end



    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    User.where(:id =>session[:user_id]).update_all(:password_salt =>password_salt,:password_hash => password_hash ) 

    redirect_to user_path(session[:user_id]), :notice => "Your password was changed successfully"
  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

     

    respond_to do |format|
      if @user.save

        #if a normal user is signing up, send a confirmation email
        if (!current_user || !@user.isConf)
            UserNotifier.send_signup_email(@user).deliver!
            if (!current_user)
               format.html { render :confirmation_process } 
            end
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
        session[:user_username] = user_params[:username]
        session[:user_isAdmin] = user_params[:isAdmin]
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
      params.require(:user).permit(:username, :email, :password, :age, :gender, :isAdmin, :isConf , :avatar)
    end
end
