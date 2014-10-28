class MediaController < ApplicationController
  before_action :set_type

  def index
    @media = type_class.all
  end

  def show
    set_attribution
    @medium = type_class.find(params[:id])
  end

  def new

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


end
