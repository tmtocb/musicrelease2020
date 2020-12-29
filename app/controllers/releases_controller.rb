class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :edit, :update, :destroy, :like]
  before_action :set_genres, :set_genres, except: [:show, :destroy]
  before_action :is_admin!, except: [:index, :show, :search]
  before_action :authenticate_user!, only: [:like]
  def index
    set_release_genre_with_criteria(params[:genre], params[:order])
  end

  def search
    set_release_genre_with_criteria(params[:genre], params[:order])
  end

  def show
  end

  def new
    @release = Release.new
  end

  def edit
  end

  def create
    @release = Release.new(release_params)

    respond_to do |format|
      if @release.save
        format.html { redirect_to releases_url, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.voted_for? @release
      @release.unliked_by current_user
      redirect_to release_path(@release)
    else
      @release.liked_by current_user
      redirect_to release_path(@release)
    end
  end

  private
    def set_release
      @release = Release.find(params[:id])
    end

    def set_genres
      @genres = Genre.all
    end

    def set_release_genre_with_criteria(requested_genre, requested_order)
      if requested_genre.nil? || requested_genre.eql?('All')
        releases_by_genre = Release.all
        @genre_name = 'All'
      else
        releases_by_genre = filter_releases_by_genre(requested_genre)
        @genre_name = requested_genre
      end
      @order = requested_order
      order_releases(requested_order, releases_by_genre)
    end

    def filter_releases_by_genre(genre_name)
      @genre = Genre.find_by(name: genre_name)
      releases = if @genre.nil?
        Release.none 
      else 
        @genre.releases
      end
    end

    def order_releases(_order, _releases)
      @releases = case _order
      when "A-Z"
        _releases.order('title ASC')
      when "Z-A"
        _releases.order('title DESC')
      when "Highest Rating"
        _releases.order('rating DESC')
      when "Lowest Rating"
        _releases.order('rating ASC')
      when "Newest First"
        _releases.order('created_at DESC')
      when "Oldest First"
        _releases.order('created_at ASC')
      else
        _releases.order('title ASC')
      end      
    end

    def release_params
      params.require(:release).permit(:title, :review, :rating, :photo, genre_ids: [])
    end
end
