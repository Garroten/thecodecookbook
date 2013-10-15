class AddTagedTextRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :taged_text, :text
  end

  def self.down
    remove_column(:recipes, :taged_text)
  end
end
