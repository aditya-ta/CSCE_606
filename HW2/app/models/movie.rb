class Movie < ActiveRecord::Base
    def self.ratings_list
        self.all.select(:rating).distinct.pluck(:rating)
    end
end