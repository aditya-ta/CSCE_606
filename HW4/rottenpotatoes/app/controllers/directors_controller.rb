class DirectorsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
    @director = @movie.director
    
    #if current movie has no director info
    if @director == nil
        flash[:notice] = "'#{@movie.title}' has no director info"
        redirect_to "/movies" and return
    end
    
    if @director == ''
        flash[:notice] = "'#{@movie.title}' has no director info"
        redirect_to "/movies" and return
    end
    
    @movies_with_same_director = Movie.others_by_same_director(@director)

  end
end