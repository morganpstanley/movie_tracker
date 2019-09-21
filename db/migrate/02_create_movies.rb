class CreateMovies < ActiveRecord::Migration
    def change
        create_table :movies do |t|
            t.string :name
            t.string :director
            t.string :genre
            t.integer :release_date
            t.integer :user_id
        end
    end
end