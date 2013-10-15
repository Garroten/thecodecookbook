class RecipesController < ApplicationController
  skip_before_filter :login_required, :only => [:index, :show]
  before_filter :get_recipes_data

  def get_recipes_data
    if current_user
      @user = current_user    
      @drafts = Recipe.where(["recipes.user_id = ? and recipes.is_draft = 1", @user.id]).paginate(:page => params[:page], :per_page => 5)    
    end
  end
  
  # GET /recipes
  # GET /recipes.xml
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
    end
  end    

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find(params[:id])

    @comment = Comment.new
    @comment.recipe = @recipe
    @comment.user = current_user
    
    if current_user == nil
      respond_to do |format|
        format.html { render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    elsif @recipe.user_id == current_user.id
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @recipe }
      end
    else
      respond_to do |format|
        format.html { render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    end
    
  end
  
  # GET /recipes/1
  # GET /recipes/1.xml
  def public_show
    @recipe = Recipe.find(params[:id])

    @comment = Comment.new
    @comment.recipe = @recipe
    @comment.user = current_user        
    
    if current_user == nil
      respond_to do |format|
        format.html { render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    elsif @recipe.user_id == current_user.id
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @recipe }
      end
    else
      respond_to do |format|
        format.html { render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    end
    
  end
  
  def add_recipe
    @recipe = Recipe.find(params[:id])
    @contribution = Contribution.where("user_id = :user_id AND recipe_id = :recipe_id", {:user_id => current_user.id, :recipe_id => params[:id]}).first
    @notice = 'This recipe is already in your Cookbook.'
    
    if @contribution == nil     
      @contribution = Contribution.new
      @contribution.recipe_id=@recipe.id
      @contribution.user_id=current_user.id
      @contribution.create_at=DateTime.now           
      @contribution.save
      @notice = 'Recipe was successfully added to your Cookbook.'      
    end  
    
    @comment = Comment.new
    @comment.recipe = @recipe
    @comment.user = current_user   
    
    if current_user == nil
      respond_to do |format|
        format.html { render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    elsif @recipe.user_id == current_user.id
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @recipe }
      end
    else
      respond_to do |format|
        format.html { 
          flash[:notice] = @notice
          render :action => "public_recipe"}
        format.xml  { render :xml => @recipe }
      end
    end
    
  end
  
  def delete_contribution
    @contribution = Contribution.where("user_id = :user_id AND recipe_id = :recipe_id", {:user_id => current_user.id, :recipe_id => params[:id]}).first              
    @contribution.destroy 
    
    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'The contribution was successfully deleted.') }    
      #format.xml  { head :ok }
    end
    
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user
    @recipe.create_at = DateTime.now
    @recipe.update_at = DateTime.now
    @recipe.user.tag(@recipe, :with => params[:recipe][:tag_list], :on => :skills)
   
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully created.') }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update_at = DateTime.now

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Recipe was successfully deleted.') }    
      #format.html { redirect_to(recipes_url) }
      #format.xml  { head :ok }
    end
  end
end
