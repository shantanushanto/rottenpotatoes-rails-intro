class Movie < ActiveRecord::Base
    #attr_accessible :title, :rating, :description, :release_date
    
    def self.get_possible_ratings
        return Movie.uniq.pluck(:rating)
    end
    
    def self.get_movie_by_ratings(rating_list)
        return Movie.where(rating: rating_list)
    end
end
