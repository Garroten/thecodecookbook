class Users::RegistrationsController < Devise::RegistrationsController   
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  before_filter :get_user_drafts
  
  layout 'signup', :only=>[:new, :create]

  def get_user_drafts 
    if current_user
      @user = User.find(current_user.id)    
      @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", current_user.id])
    end  
  end

end