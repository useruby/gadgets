class GadgetsController < InheritedResources::Base
  before_filter :authenticate_user!
  
  protected
  def begin_of_association_chain
    current_user
  end

  def collection
    if params[:gadget].try(:[], :filter)
      @gadgets ||= end_of_association_chain.filter_by_name(params[:gadget][:filter])
    else
      super
    end
  end
end
