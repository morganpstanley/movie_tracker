class ApplicationController < Sinatra::Base

    enable :sessions
    set :session_secret, "secret_secret_ive_got_a_secret"
    set :views, 'app/views'

    get '/' do
        redirect to 'users/login'
    end

    helpers do
        def logged_in?
            !!session[:id]
        end

        def current_user
            User.find(session[:id])
        end
    end

end
