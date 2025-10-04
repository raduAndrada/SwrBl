module NutritionalValues

using JSON3

@kwdef mutable struct NutritionalValue
    ingredients::Dict{String, Float64} = Dict()
    values::Dict{String, Float64} = Dict()
    kcal::Union{Float64, Nothing} = nothing
    kj::Union{Float64, Nothing} = nothing
end

# JSON3 serialization
JSON3.@iostruct NutritionalValueIO begin
    ingredients::Dict{String, Float64}
    values::Dict{String, Float64}
    kcal::Union{Float64, Nothing}
    kj::Union{Float64, Nothing}
end

end