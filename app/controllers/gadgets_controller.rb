class GadgetsController < InheritedResources::Base
  before_filter :authenticate_user!
 
  def create
    create!{gadgets_path}
  end

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

  def build_resource_params
    [params.fetch(:gadget, {}).permit(:name, :description, :image)]
  end
end
