class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :text
      t.datetime :create_at
      t.datetime :update_at
      t.integer :user_id
      t.integer :recipe_id
    end
    
    remove_column(:recipes, :taged_text)
  end

  def self.down
    drop_table :comments
    add_column :recipes, :taged_text, :text
  end
end
