class Medium < ActiveRecord::Base

  def self.types
    %w(Album Book Movie)
  end
end
