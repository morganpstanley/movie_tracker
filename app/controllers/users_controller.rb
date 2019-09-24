require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/users/login' do
        if logged_in?
            redirect to "/users/#{current_user.slug}"
        else
            erb :'users/login'
        end
    end

    post '/users/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect to "/users/#{user.slug}"
        else
            redirect to '/users/login'
        end
    end
    
    get '/users' do
        @users = User.all 
        erb :'users/index'
    end

    post '/users/new' do
        if params[:user][:username].empty? || params[:user][:password].empty?
            flash[:message] = "ERROR: You need to include both a username and a password"
            redirect to '/users/new'
        else    
        user = User.create(params[:user])
        session[:id] = user.id
        redirect to "/users/#{user.slug}"
        end
    end

    get '/users/new' do
        if !logged_in?
            erb :'users/new'
        else
            redirect to "/users/#{current_user.slug}"
        end
    end

    get '/users/:slug' do
        @current_user = current_user
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/users/:slug/edit' do
        if current_user.slug == params[:slug]
            @user = User.find_by_slug(params[:slug])
            erb :'users/edit'
        else
            redirect to '/users'
        end
    end

    patch '/users/:slug' do
        current_user.update(params[:user])
        redirect to "/users/#{current_user.slug}"
    end

    delete '/users/:slug/delete' do
        if current_user.slug == params[:slug]
            User.find_by_slug(params[:slug]).delete
            redirect to '/users'
        end
    end

    get '/logout' do
        session.clear
        redirect to '/users/login'
    end

end