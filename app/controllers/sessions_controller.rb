class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            #log the user in
            log_in user
            redirect_to user
        else
            #redirect to login page again with error
            flash.now[:danger] = 'Invalid Email/Password combination'
            render 'new'
        end
    end

    def destroy
		log_out
		redirect_to index_url
    end
end
