module Repositories

abstract type AbstractRepository{T} end

function save!(repo::AbstractRepository{T}, entity::T) where T
    error("Not implemented")
end

function find_all(repo::AbstractRepository{T}) where T
    error("Not implemented")
end

end