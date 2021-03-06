class User < ActiveRecord::Base
    has_secure_password

    has_many :movies

    def slug
        self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find{ |i| i.slug == slug }
    end
end