module Models

# Export all model types
export Category, Dish, Ingredient, NutritionalValue, Label

# Include all model files
include("Category.jl")
include("Dish.jl")
include("Ingredient.jl") 
include("NutritionalValue.jl")

end