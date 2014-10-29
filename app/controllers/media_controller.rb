class MediaController < ApplicationController
  before_action :set_type
  before_action :find_medium, only: [:index, :show, :upvote]
  before_action :set_attribution, only: [:show, :new]
  # new and show apparently don't need to be explicitly defined; before_actions will run before views are rendered

  def index
    @media = type_class.all
  end

  def create
    @medium = type_class.new(medium_params)
    if @medium.save
      redirect_to "/#{@type.downcase.pluralize}", notice: "Created new #{@type.downcase} #{@medium.title}." # find out what notice does
    else
      render :new
    end
  end

  def upvote
    @medium.update(votes: @medium.votes+1)
    render :index # figure out how to tell this method what page it was called from?
  end

  private

    def set_type
      @type = params[:type] ? params[:type] : "Medium"
    end

    def type_class
      @type.constantize # looks for a declared constant with name type
    end

    def set_attribution
      @attribution = case @type
        when "Book" then "Author: "
        when "Movie" then "Director: "
        when "Album" then "Artist: "
        else "Creator: "
      end
    end

    def medium_params
      params.require(:media).permit(:title, :author, :description, :votes)
    end

    def find_medium
      @medium = params[:id] ? type_class.find(params[:id]) : nil
    end
end
