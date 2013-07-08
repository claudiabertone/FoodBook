class Recipe < ActiveRecord::Base
 attr_accessible :name, :piatto, :cucina, :vegetariana, :vegana, :latticini, :glutine, :descrizione

  belongs_to :user

  # default_scope order: 'recipes.created_at DESC'

  validates :user_id, presence: true

  validates :name, presence: true
  validates :piatto, presence: true
  validates :cucina, presence: true

  validates :descrizione, presence: true
  default_scope order: 'recipes.created_at DESC'

#def self.search(search)
   #if search
    # find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
   #else
    #scoped
   #end
 #end

 #def self.search(name)
 #  recipes = order(:name)
 #  recipes = recipes.where("name like ?", "%#{name}%") if name.present?
 # recipes
 #end



  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end







end
