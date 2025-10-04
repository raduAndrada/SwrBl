module Dishes

using JSON3
using ..Subcategories
using ..Ingredients
using ..NutritionalValues

# Labels enum
@enum Label SUGAR_FREE GLUTEN_FREE FISH VEGAN

@kwdef mutable struct Dish
    id::Union{Int, Nothing} = nothing
    name::String
    description::Union{String, Nothing} = nothing
    quantity::Union{String, Nothing} = nothing
    price::Union{Float64, Nothing} = nothing
    labels::Union{Vector{Label}, Nothing} = nothing
    subcategory::Union{Subcategories.Subcategory, Nothing} = nothing
    subcategory_id::Union{Int, Nothing} = nothing
    ingredients::Union{Vector{Ingredients.Ingredient}, Nothing} = nothing
    nutritionalValue::Union{NutritionalValues.NutritionalValue, Nothing} = nothing
end

end