class MoviesController < ApplicationController

    get '/movies' do
        @movies = Movie.all
        erb :'movies/index'
    end

    post '/movies' do
        if params[:movie][:name].empty? || params[:movie][:director].empty? || params[:movie][:release_date].empty? || params[:movie][:genre].empty?
            flash[:message] = "ERROR: All fields must be filled"
            redirect to '/movies/new'
        elsif params[:movie][:release_date].to_i == 0
            flash[:message] = "ERROR: Release date must be an integer"
            redirect to '/movies/new'
        else
            movie = Movie.create(params[:movie])
            current_user.movies << movie
            redirect to "/movies/#{movie.slug}"
        end
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
        if current_user.movies.include?(@movie)
            erb :'movies/edit'
        else
            redirect to '/movies'
        end
    end

    patch '/movies/:slug' do
        movie =  Movie.find_by_slug(params[:slug])
        if params[:movie][:name].empty? || params[:movie][:director].empty? || params[:movie][:release_date].empty? || params[:movie][:genre].empty?
            flash[:message] = "ERROR: All fields must be filled"
            redirect to "/movies/#{movie.slug}/edit"
        elsif params[:movie][:release_date].to_i == 0
            flash[:message] = "ERROR: Release date must be an integer"
            redirect to "/movies/#{movie.slug}/edit"
        else
        movie.update(params[:movie])
        redirect to "/movies/#{movie.slug}"
        end
    end

    delete '/movies/:slug/delete' do
        Movie.find_by_slug(params[:slug]).delete
        redirect to '/movies'
    end

end