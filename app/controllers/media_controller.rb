class MediaController < ApplicationController
  before_action :set_type

  def index
    @media = type_class.all
  end

  def show
    @medium = type_class.find(params[:id])
    set_attribution
  end

  def new
    set_attribution
  end

  def create
    @medium = type_class.new(medium_params)
    if @medium.save
      redirect_to "/#{@type.downcase.pluralize}"
    else
      render :new
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
      params.require(:media).permit(:title, :author, :description)
    end
end
