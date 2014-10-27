class MediaController < ApplicationController

  def index
    @media = type_class.all
  end

  private
    def set_type
      @type = params[:type]
    end

    def type
      Medium.types.include?(params[:type]) ? params[:type] : "Medium"
    end

    def type_class
      type.constantize
    end

end
