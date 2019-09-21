class UsersController < ApplicationController

    get '/users' do
        @users = User.all 
        erb :'users/index'
    end

    post '/users' do
        user = User.create(params[:user])
        redirect to "/users/#{user.slug}"
    end

    get '/users/new' do
        erb :'users/new'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/users/:slug/edit' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/edit'
    end

    patch '/users/:slug' do
        user =  User.find_by_slug(params[:slug])
        user.update(params[:user])
        redirect to "/users/#{user.slug}"
    end

    delete '/users/:slug/delete' do
        User.find_by_slug(params[:slug]).delete
        redirect to '/users'
    end

end