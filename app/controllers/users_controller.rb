require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/users/login' do
        if logged_in?
            redirect to "/users/#{current_user.slug}"
            flash[:message] = "ERROR: You are already logged in"
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
            flash[:message] = "ERROR: incorrect username or password"
            redirect to '/users/login'
        end
    end
    
    get '/users' do
        if logged_in?
            @users = User.all 
            erb :'users/index'
        else
            redirect to '/users/login'
        end
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
            flash[:message] = "ERROR: You are already logged in"
            redirect to "/users/#{current_user.slug}"
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'users/show'
        else
            redirect to '/users/login'
        end
    end

    get '/users/:slug/edit' do
        if current_user.slug == params[:slug]
            @user = User.find_by_slug(params[:slug])
            erb :'users/edit'
        else
            flash[:message] = "ERROR: Users can only edit their own profile"
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