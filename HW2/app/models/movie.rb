class Movie < ActiveRecord::Base
    #################################
    
    def self.ratings_enumerator
        # enumerable collection of all possible values of a movie rating
        Movie.select(:rating).distinct.pluck(:rating)
    end
    
    ##################################
end