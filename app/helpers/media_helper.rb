module MediaHelper

  # this is how to use dynamically-generated named routes instead of clumsy code like link_to "#{thing.title}", "/#{thing.type.downcase.pluralize}/#{thing.id}"
  # ref: http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-3/
  # not currently used but can integrate it if time

  def sti_medium_path(type="Medium", medium=nil, action=nil)
    send "#{format_sti(action, type, medium)}_path", medium # blahblah_path is the METHOD name, medium is the argument to the method. cool!
  end

  def format_sti(action, type, medium)
    action || medium ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
    # what this actually does:
    # if action || medium # medium will be defined for a specific item, e.g. from show page vs from index page
    #   if action
    #     return "#{action}_#{type.underscore}"
    #   else
    #     return "#{type.underscore}"
    #   end
    # else
    #   return "#{type.underscore.pluralize}"
    # end
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end
end
