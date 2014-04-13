class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    if current_user.try(:admin?)
      @comments = Comment.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @comments }
      end
    else
      redirect_to root_path
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    recipe = Recipe.find(params[:recipe_id])
    @comment.recipe = recipe
    user = User.find(params[:user_id])
    @comment.user = user
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.create_at = DateTime.now
    @comment.update_at = DateTime.now
    @recipe =  recipe = Recipe.find(@comment.recipe.id)
      
    respond_to do |format|
      if @comment.save
        recipe = @comment.recipe
        user = @comment.user
        @comment = Comment.new          
        @comment.recipe = recipe
        @comment.user = user
          
        format.html { render :template => 'recipes/public_recipe', :notice => 'Comment was successfully created.' }
        #format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :template => 'recipes/public_recipe' }
        #format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
