class Movie < ActiveRecord::Base
    
    def self.others_by_same_director(director)
        if director
            return self.where(:director => director)
        else
            return nil
        end
    end
end
