class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :drafts, :contributions, :user_search]

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", params[:id]])
    if @user.id != current_user.id
      redirect_to :action => :index, :controller => :home
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(["recipes.user_id = ?", params[:id]]).paginate(:page => params[:page], :per_page => 5)
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", params[:id]])
    
    if @user.id == current_user.id
      @user_tags = @user.owned_tags.limit(50) 
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
    else
      @user_tags = @user.owned_tags.limit(15)      
      respond_to do |format|
        format.html { render :action => "public_profile"}
        format.xml  { render :xml => @user }
      end
    end    
  end

  def drafts
    @user = User.find(params[:id])
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", params[:id]]).paginate(:page => params[:page], :per_page => 5)

    if @user.id == current_user.id
      @user_tags = @user.owned_tags.limit(50) 
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @drafts }
      end
    else
      @user_tags = @user.owned_tags.limit(15)
      @recipes = Recipe.where(["recipes.user_id = ?", params[:id]]).paginate(:page => params[:page], :per_page => 5)
      respond_to do |format|
        format.html { render :action => "public_profile"}
        format.xml  { render :xml => @user }
      end
    end
  end

  def contributions
    @user = User.find(params[:id])    
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", params[:id]]).paginate(:page => params[:page], :per_page => 5)    
    @contributions = @user.contributions.paginate(:page => params[:page], :per_page => 5)

    if @user.id == current_user.id
      @user_tags = @user.owned_tags.limit(50) 
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @contributions }
      end
    else
      @user_tags = @user.owned_tags.limit(15)
      @recipes = Recipe.where(["recipes.user_id = ?", params[:id]]).paginate(:page => params[:page], :per_page => 5)
      respond_to do |format|
        format.html { render :action => "public_profile"}
        format.xml  { render :xml => @user }
      end
    end
  end
  
  def user_search  
    @user = current_user
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", current_user.id])
    @user_tags = @user.owned_tags.limit(50) 
    @recipes = Recipe.search do
      fulltext params[:topic], :fields => [:title, :text, :tag_list] 
      with :user_id, current_user.id
      paginate(:page => 1, :per_page => 10)
    end
    render :action => "recipes_search"
  end
  
  def draft_search  
    @user = current_user
    @draftsn = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", current_user.id])
    @user_tags = @user.owned_tags.limit(50) 
    @drafts = Recipe.search do
      fulltext params[:topic], :fields => [:title, :text, :tag_list] 
      with :user_id, current_user.id
      with :is_draft, true
      paginate(:page => 1, :per_page => 10)
    end
    render :action => "drafts_search"
  end
  
  def contribution_search  
    @user = current_user
    @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", current_user.id])
    @user_tags = @user.owned_tags.limit(50) 
    @contributions = Contribution.search do
      fulltext params[:topic], :fields => [:recipe_text, :recipe_title] 
      with :user_id, current_user.id
      paginate(:page => 1, :per_page => 10)
    end
    render :action => "contributions_search"
  end
  
  # render new.rhtml
  def new    
    @user = User.new
    render :layout => 'login'
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fsixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new', :layout => 'login'
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    logger.info "updating"
    @user = User.find(params[:id])
    @user.updated_at = DateTime.now

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
