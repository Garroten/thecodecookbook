class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :title
      t.text :text
      t.datetime :create_at
      t.datetime :update_at
      t.integer :user_id
    end
  end

  def self.down
    drop_table :recipes
  end
end
