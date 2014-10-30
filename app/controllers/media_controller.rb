class MediaController < ApplicationController
  before_action :set_type, :find_medium
  before_action :set_attribution, only: [:show, :new, :edit]
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
    @medium.update(votes: @medium.votes+1) # figure out how to move this to model
    render :index # figure out how to tell this method what page it was called from?
  end

  def update
    @medium.update(medium_params)
    if @medium.save
      redirect_to "/#{@type.downcase.pluralize}", notice: "Edited #{@medium.title}"
    end
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
      if @medium
        params.require(@type.downcase).permit(:title, :author, :description, :votes)
      else
        params.require(:media).permit(:title, :author, :description, :votes)
      end
    end

    def find_medium
      @medium = params[:id] ? type_class.find(params[:id]) : nil
    end
end
