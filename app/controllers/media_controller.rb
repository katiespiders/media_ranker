class MediaController < ApplicationController

  def index
    @media = type_class.all
  end

  def show
    @medium = type_class.find(params[:id])
  end

  private
    def set_type
      @type = params[:type]
    end

    def type
      Medium.types.include?(params[:type]) ? params[:type] : "Medium"
    end

    def type_class
      type.constantize # looks for a declared constant with name type
    end

end
