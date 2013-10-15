class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  
  searchable do
    integer :recipe_id, :references => Recipe
    integer :user_id,   :references => User   
    text :recipe_text do
      recipe.text
    end
    text :recipe_title do
      recipe.title
    end
  end
end
