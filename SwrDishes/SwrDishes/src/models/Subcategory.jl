module Subcategories

using ..Categories

@kwdef mutable struct Subcategory
    id::Union{Int, Nothing} = nothing
    name::String
    icon::String
    category::Union{Categories.Category, Nothing} = nothing
    category_id::Union{Int, Nothing} = nothing
end

end