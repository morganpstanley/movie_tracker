class MoviesController < ApplicationController

    get '/movies' do
        if logged_in?
            @movies = Movie.all
            erb :'movies/index'
        else
            redirect to '/users/login'
        end
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
            redirect to '/users/login'
        end
    end

    get '/movies/:slug' do
        if logged_in?
            @movie = Movie.find_by_slug(params[:slug])
            erb :'movies/show'
        else
            redirect to '/users/login'
        end
    end

    get '/movies/:slug/edit' do
        @movie = Movie.find_by_slug(params[:slug])
        if current_user.movies.include?(@movie)
            erb :'movies/edit'
        else
            flash[:message] = "ERROR: You do not have access to this webpage"
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
        movie = Movie.find_by_slug(params[:slug])
        if current_user.movies.include?(movie)
            movie.delete
        end
        redirect to '/movies'
    end

end