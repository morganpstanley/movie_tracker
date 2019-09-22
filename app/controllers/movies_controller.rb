class MoviesController < ApplicationController

    get '/movies' do
        @movies = Movie.all
        erb :'movies/index'
    end

    post '/movies' do
        movie = Movie.create(params[:movie])
        redirect to "/movies/#{movie.slug}"
    end

    get '/movies/new' do
        if logged_in?
            erb :'movies/new'
        else
            redirect to '/movies'
        end
    end

    get '/movies/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        @current_user = current_user
        erb :'movies/show'
    end

    get '/movies/:slug/edit' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :'movies/edit'
    end

    patch '/movies/:slug' do
        movie =  Movie.find_by_slug(params[:slug])
        movie.update(params[:movie])
        redirect to "/movies/#{movie.slug}"
    end

    delete '/movies/:slug/delete' do
        Movie.find_by_slug(params[:slug]).delete
        redirect to '/movies'
    end

end