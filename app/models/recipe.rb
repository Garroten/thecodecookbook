class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :conributors, :join_table => :contributions, :class_name => 'User', :association_foreign_key => 'user_id'  

  acts_as_taggable
  acts_as_taggable_on :skills
  
  validates :title, :presence   => true,
                    :length     => { :maximum => 255 }
  
  validates :text,  :presence   => true
  
  validates :tag_list, :presence   => true,
                       :length     => { :maximum => 255 }  
  
  searchable do
    text    :title, :text
    integer :id
    integer :user_id, :references => User
    time    :create_at
    time    :update_at    
    boolean :is_draft
    text :tag_list, :skill_list 
  end
                    
end
