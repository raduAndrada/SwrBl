using ..Models

struct InMemoryCategoryRepository <: Repositories.AbstractRepository{Models.Category}
    categories::Vector{Models.Category}
    next_id::Int
    
    function InMemoryCategoryRepository()
        return new(Models.Category[], 1)
    end
end

function Repositories.save!(repo::InMemoryCategoryRepository, category::Models.Category)
    if isnothing(category.id)
        category.id = repo.next_id
        repo.next_id += 1
    else
        # Update existing
        index = findfirst(c -> c.id == category.id, repo.categories)
        if !isnothing(index)
            repo.categories[index] = category
            return category
        end
    end
    
    push!(repo.categories, category)
    return category
end

function Repositories.find_all(repo::InMemoryCategoryRepository)
    return repo.categories
end