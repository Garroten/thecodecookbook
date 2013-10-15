class AddRecipeMarkedText < ActiveRecord::Migration
  def self.up
    add_column :recipes, :marked_text, :text
  end

  def self.down
    remove_column(:recipes, :marked_text)
  end
end
