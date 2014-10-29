class Medium < ActiveRecord::Base

  def self.types
    %w(Album Book Movie) # list of all types of Medium (classes that inherit from it) as strings; type.constantize (in MediaController) will look for classes with these names.
    #to do: look up %w syntax
  end
end
