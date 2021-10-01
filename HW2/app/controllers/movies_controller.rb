class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      
      @all_ratings = Movie.ratings_list
    
      # RATINGS CONTROLLER
      if params[:ratings] 
        @ticked_ratings = params[:ratings].keys
        
        if @ticked_ratings != session[:ratings]
          session[:ratings] = @ticked_ratings
        end
        @movies = Movie.where('rating in (?)', @ticked_ratings)
      else
        if session[:ratings]
          @ticked_ratings = session[:ratings]
        else
          @ticked_ratings = @all_ratings
        end
        @movies = Movie.where('rating in (?)', @ticked_ratings)
      end
    
      
      # SORTING CONTROLLER
      if params[:sorting_by]
        @sorting = params[:sorting_by]
        
        if params[:sorting_by] != session[:sorting_by]
          session[:sorting_by] = params[:sorting_by]
        end
        
        if @sorting == 'title'
          @movies = @movies.order(@sorting)
          @title_class = 'hilite'
          @title_class = 'bg-warning'
        
        elsif @sorting == 'release_date'
          @movies = @movies.order(@sorting)
          @release_date_class = 'hilite'
          @release_date_class = 'bg-warning'
        end
        
      else
        @sorting = session[:sorting_by]
        
        if @sorting == 'title'
          @movies = @movies.order(@sorting)
          @title_class = 'hilite'
          @title_class = 'bg-warning'
        
        elsif @sorting == 'release_date'
          @movies = @movies.order(@sorting)
          @release_date_class = 'hilite'
          @release_date_class = 'bg-warning'
        end
      end

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