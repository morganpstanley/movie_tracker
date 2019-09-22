class UsersController < ApplicationController

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
        user = User.create(params[:user])
        session[:id] = user.id
        redirect to "/users/#{user.slug}"
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

end