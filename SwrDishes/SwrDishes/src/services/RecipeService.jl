module Services

using ..Models
using ..Repositories

abstract type AbstractService end

struct RecipeService <: AbstractService
    recipe_repository
    # mapper would go here
end

function Base.get(service::RecipeService, id::Int)
    # Implementation would depend on your repository
    return nothing
end

end