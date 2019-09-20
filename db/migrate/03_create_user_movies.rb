class CreateUserMovies < ActiveRecord::Migration
    def change
        create_table :user_movies do |t|
            t.integer :move_id
            t.integer :user_id
        end
    end
end