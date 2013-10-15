class AddUsersGenderBirthDateCountryCitySocial < ActiveRecord::Migration
  def self.up
    add_column :users, :gener,            :integer,               :default => 0,  :null => true
    add_column :users, :birth_date,       :date,                                  :null => true
    add_column :users, :country,          :string, :limit => 255, :default => '', :null => true
    add_column :users, :city,             :string, :limit => 255, :default => '', :null => true    
    add_column :users, :user_web_site,    :string, :limit => 255, :default => '', :null => true
    add_column :users, :twitter_profile,  :string, :limit => 255, :default => '', :null => true
    add_column :users, :facebook_profile, :string, :limit => 255, :default => '', :null => true
    add_column :users, :linkedin_profile, :string, :limit => 255, :default => '', :null => true
    add_column :users, :github_profile,   :string, :limit => 255, :default => '', :null => true
  end

  def self.down
    remove_column :users, :gener
    remove_column :users, :birth_date
    remove_column :users, :country
    remove_column :users, :city
    remove_column :users, :user_web_site
    remove_column :users, :twitter_profile
    remove_column :users, :facebook_profile
    remove_column :users, :linkedin_profile
    remove_column :users, :github_profile
  end
end
