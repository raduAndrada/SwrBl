module Services

export AbstractService, RecipeService

abstract type AbstractService end

struct RecipeService <: AbstractService
    recipe_repository
end

end