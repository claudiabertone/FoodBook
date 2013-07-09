class Ingredient < ActiveRecord::Base
  attr_accessible :ingrediente, :quantit, :tipoquantit

  belongs_to :recipe

# default_scope order: 'recipes.created_at DESC'

  default_scope order: 'ingredients.created_at DESC'

end