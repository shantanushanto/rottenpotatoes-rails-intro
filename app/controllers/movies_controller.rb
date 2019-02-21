class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #@movies = Movie.get_movie_by_ratings(["R","G"])
 
    @title_id = "title_header"
    @date_id = "release_date_header"
    @form_id = "ratings_form"
    @form_submit_id = "ratings_submit"
    
    @all_ratings = Movie.get_possible_ratings # this is for part2
    

    unless params[:ratings].nil?
      @filtered_ratings = params[:ratings].keys
      #session[:filtered_ratings] = @filtered_ratings
      #@movies = Movie.order("title asc").find_all_by_rating(@filtered_ratings)
      #render :text => @filtered_ratings.inspect
      @movies = Movie.get_movie_by_ratings(@filtered_ratings)
      return
    end


    if params[:title_sort] == "on"
      @movies = Movie.order("title asc")
      @movie_highlight = "hilite"
    elsif params[:date_sort] == "on"
      @movies = Movie.order("release_date asc")
      @date_highlight = "hilite"
    else
      @movies = Movie.all
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

end
