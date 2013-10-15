class SearchController < ApplicationController
  skip_before_filter :login_required, :only => [:search]
  
  def search 
    #@recipes = Recipe.tagged_with(params[:topic]).paginate(:page => params[:page], :per_page => 10)
    @recipes = Recipe.search do
      fulltext params[:topic], :fields => [:title, :text, :tag_list] 
      paginate(:page => 1, :per_page => 10)
    end
    render :index
  end 
  
end
