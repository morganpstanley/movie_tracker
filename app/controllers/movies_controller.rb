class MoviesController < ApplicationController

    get '/movies' do
        @movies = Movie.all
        erb :'movies/index'
    end

    post '/movies' do
        movie = Movie.new(params[:movie])
        redirect to "/movies/#{movie.slug}"
    end

    get '/movies/new' do
        erb :'movies/new'
    end

    get '/movies/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :"movies/show"
    end

    get '/movies/:slug/edit' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :"movies/edit"
    end

    patch '/movies/:slug' do
        movie =  Movie.find_by_slug(params[:slug])
        movie.update(params[:movie])
        redirect to "/movies/#{movie.slug}"
    end

end