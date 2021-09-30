class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      
      #controller code for sorting and rating
      #@movies = Movie.all
      ##########################################
      
      all_ratings = {"G": 1, "R":1,"PG-13":1, "PG":1}#Movie.ratings_enumerator
      #all_ratings_hash = Hash[@all_ratings.map{|rating| [rating, rating]}]
      @ratings =  params[:ratings] || session[:ratings] || all_ratings
      #fill in clickedRatings to show in the check boxed
      @sortings = params[:sort] || session[:sort]
      @movies = Movie.where(rating:@ratings.keys).order(@sortings)
      
      
      if params[:sort] != session[:sort]
        session[:sort] = @sortings
      end
        
      if params[:ratings] != session[:ratings]
        session[:ratings] = @ratings
      end
      
      if session[:sort] == 'title'
        @sort = 'title'
      elsif session[:sort] == 'release_date'
        @sort = 'release_date'
      else
        @sort="none"
      end
      
      ###########################################
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
      @title = Title.order(params[:sort])
      # add sorting funtionality
      
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end