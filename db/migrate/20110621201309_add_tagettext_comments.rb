class AddTagettextComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :taged_text, :text
  end

  def self.down
    remove_column(:comments, :taged_text)
  end
end
