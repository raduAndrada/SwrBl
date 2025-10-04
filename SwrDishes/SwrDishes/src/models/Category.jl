module Categories

@kwdef mutable struct Category
    id::Union{Int, Nothing} = nothing
    name::String
    icon::String
end

end