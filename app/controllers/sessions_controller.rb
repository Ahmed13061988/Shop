class SessionsController < ApplicationController
    skip_before_action :redirect_if_not_logged_in
  
     def home 
     end 
  
  
     def new  
        @user = User.new
     end 
  
    def create
          @user = User.find_by(username: params[:user][:username])
      
          if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
          else
            #  byebug
            flash[:errors] = ["Incorrect Username or Password"]
            redirect_to login_path notice: "Invalid Input!"
          end
    end
  
  
    def google_omniauth_create
        omniauth = request.env['omniauth.auth']['info']
        @user = User.find_or_create_by(email: omniauth['email']) do |u|
        u.username = omniauth["name"]
        u.password = SecureRandom.hex
        end 
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end
  
    def destroy 
        session.clear  
        redirect_to '/'
    end 
    
      private
    
        # def auth
        #   request.env['omniauth.auth']
        # end
     
      end