module Ingredients

using JSON3

@kwdef mutable struct Ingredient
    shortName::String = ""
    longName::String = ""
    description::String = ""
    quantity::Union{Float64, Nothing} = nothing
    um::Union{String, Nothing} = nothing
end

# JSON3 serialization
JSON3.@iostruct IngredientIO begin
    shortName::String
    longName::String
    description::String
    quantity::Union{Float64, Nothing}
    um::Union{String, Nothing}
end

end