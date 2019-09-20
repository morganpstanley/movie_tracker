class Movie < ActiveRecord::Base
    has_many :user_movies
    has_many :users, through: :user_movies

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find{ |i| i.slug == slug }
    end
end