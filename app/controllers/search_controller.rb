class SearchController < ApplicationController
  before_filter :authenticate_user!, :except => [:search]
  
  def search 
    @recipes = Recipe.search do
      fulltext params[:topic], :fields => [:title, :text, :tag_list] 
      paginate(:page => 1, :per_page => 10)
    end
    render :index
  end 
  
end
