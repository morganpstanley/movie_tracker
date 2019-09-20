class CreateMovies < ActiveRecord::Migration
    def change
        create_table :movies do |t|
            t.string :name
            t.string :user_id
        end
    end
end