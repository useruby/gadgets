class GadgetsController < InheritedResources::Base
  before_filter :authenticate_user!
  
  protected
  def begin_of_association_chain
    current_user
  end

  def collection
    if params[:filter]
      @gadgets ||= end_of_association_chain.search(params[:filter])
    else
      super
    end
  end
end
