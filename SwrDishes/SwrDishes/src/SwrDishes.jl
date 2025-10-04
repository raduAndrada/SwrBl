module SwrDishes

using Parameters, JSON3, UUIDs

# Export public API
export main, setup_initial_data!
export Category, Dish, Ingredient, NutritionalValue, Label

# Model definitions
@kwdef mutable struct Category
    id::Union{Int, Nothing} = nothing
    name::String
    icon::String
end

@kwdef mutable struct Ingredient
    shortName::String = ""
    longName::String = ""
    description::String = ""
    quantity::Union{Float64, Nothing} = nothing
    um::Union{String, Nothing} = nothing
end

@kwdef mutable struct NutritionalValue
    ingredients::Dict{String, Float64} = Dict()
    values::Dict{String, Float64} = Dict()
    kcal::Union{Float64, Nothing} = nothing
    kj::Union{Float64, Nothing} = nothing
end

@enum Label SUGAR_FREE GLUTEN_FREE FISH VEGAN

@kwdef mutable struct Dish
    id::Union{Int, Nothing} = nothing
    name::String
    description::Union{String, Nothing} = nothing
    quantity::Union{String, Nothing} = nothing
    price::Union{Float64, Nothing} = nothing
    labels::Union{Vector{Label}, Nothing} = nothing
    ingredients::Union{Vector{Ingredient}, Nothing} = nothing
    nutritionalValue::Union{NutritionalValue, Nothing} = nothing
end

# Simple in-memory repository
mutable struct InMemoryRepository{T}
    entities::Vector{T}
    next_id::Int
    
    function InMemoryRepository{T}() where T
        return new{T}(T[], 1)
    end
end

function save!(repo::InMemoryRepository{T}, entity::T) where T
    if isnothing(getfield(entity, :id))
        # Use reflection to set the id field
        entity = set_id(entity, repo.next_id)
        repo.next_id += 1
    end
    push!(repo.entities, entity)
    return entity
end

function find_all(repo::InMemoryRepository{T}) where T
    return repo.entities
end

# Helper function to set id (since we can't mutate struct fields directly in some cases)
function set_id(entity::T, id::Int) where T
    if T == Category
        return Category(; id=id, name=entity.name, icon=entity.icon)
    elseif T == Dish
        return Dish(;
            id=id,
            name=entity.name,
            description=entity.description,
            quantity=entity.quantity,
            price=entity.price,
            labels=entity.labels,
            ingredients=entity.ingredients,
            nutritionalValue=entity.nutritionalValue
        )
    end
    return entity
end

function setup_initial_data!()
    println("📊 Setting up initial SwrDishes data...")
    
    # Initialize repositories
    category_repo = InMemoryRepository{Category}()
    dish_repo = InMemoryRepository{Dish}()
    
    # Create categories
    categories = [
        Category(name="Sandwiches", icon="fa-bread-slice"),
        Category(name="ToGo", icon="fa-person-running"),
        Category(name="Brunch", icon="fa-bacon"),
        Category(name="Drinks", icon="fa-martini-glass")
    ]
    
    for category in categories
        save!(category_repo, category)
    end
    
    # Create ingredients
    ingredients = [
        Ingredient(shortName="ingredient01", longName="ingredient01", description="description01"),
        Ingredient(shortName="ingredient02", longName="ingredient02", description="description02", quantity=100.0, um="g"),
        Ingredient(shortName="ingredient03", longName="ingredient03", description="description03")
    ]
    
    # Create nutritional value
    nv = NutritionalValue(
        ingredients=Dict("ingredient01" => 40.0, "ingredient02" => 40.0, "ingredient03" => 20.0),
        values=Dict("carbs" => 36.0, "fiber" => 7.0, "fats" => 8.0, "saturated" => 1.0),
        kcal=157.0,
        kj=1132.0
    )
    
    # Create dishes
    dishes = [
        Dish(
            name="dish01",
            description="test description",
            quantity="350g",
            price=10.0,
            labels=[SUGAR_FREE, GLUTEN_FREE],
            ingredients=ingredients[1:3],
            nutritionalValue=nv
        ),
        Dish(
            name="dish02", 
            description="test description 2",
            quantity="150g",
            price=25.0,
            labels=[FISH],
            ingredients=ingredients[1:2]
        ),
        Dish(
            name="dish03",
            description="test description 3", 
            quantity="1 piece",
            price=40.0,
            labels=[VEGAN],
            ingredients=ingredients
        )
    ]
    
    for dish in dishes
        save!(dish_repo, dish)
    end
    
    # Demonstrate JSON3 usage
    println("\n🔧 JSON3 Serialization Demo:")
    dish_json = JSON3.write(dishes[1])
    println("   Dish as JSON: $(dish_json[1:100])...")
    
    # Show summary
    println("\n📊 Data Summary:")
    println("   Categories: $(length(find_all(category_repo)))")
    println("   Dishes: $(length(find_all(dish_repo)))")
    println("   Ingredients: $(length(ingredients))")
    
    return (categories=find_all(category_repo), dishes=find_all(dish_repo))
end

function main()
    println("=" ^ 50)
    println("   🍽️  SwrDishes Restaurant Management System")
    println("=" ^ 50)
    
    data = setup_initial_data!()
    
    println("\n📋 Menu Overview:")
    for (i, category) in enumerate(data.categories)
        category_dishes = filter(d -> true, data.dishes)  # In real app, filter by category
        println("   $(i). $(category.name) ($(length(category_dishes)) dishes)")
    end
    
    println("\n🎉 " * "Application started successfully!")
    println("💡 " * "Try: using JSON3; JSON3.write(your_data)")
end

# Auto-run if executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

end