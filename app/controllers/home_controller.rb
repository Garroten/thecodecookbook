class HomeController < ApplicationController
  skip_before_filter :login_required, :only => [:index, :tag]
  before_filter :get_users
  layout 'home'
  
  def get_users
    @users=User.find(:all, :limit => 3, :order => 'created_at DESC') 
  end
  
  def index
    @tags = Recipe.tag_counts_on(:tags)
    #@recipe = Recipe.find(:last)
    render :index
  end  
  
end
