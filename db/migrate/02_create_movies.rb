class CreateMovies < ActiveRecord::Migration
    def change
        create_table :movies do |t|
            t.string :name
            t.string :director
            t.string :genre
            t.string :user_id
            t.integer :release_date
        end
    end
end