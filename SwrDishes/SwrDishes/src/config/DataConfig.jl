module DataConfig

using ..Models
using ..Repositories

function setup_initial_data!(category_repo)
    println("📊 Setting up initial data...")
    
    # Create categories
    sandwiches = Models.Category(name="Sandwiches", icon="fa-bread-slice")
    togo = Models.Category(name="ToGo", icon="fa-person-running") 
    brunch = Models.Category(name="Brunch", icon="fa-bacon")
    drinks = Models.Category(name="Drinks", icon="fa-martini-glass")
    
    Repositories.save!(category_repo, sandwiches)
    Repositories.save!(category_repo, togo)
    Repositories.save!(category_repo, brunch)
    Repositories.save!(category_repo, drinks)
    
    categories = Repositories.find_all(category_repo)
    println("✅ Created $(length(categories)) categories")
    
    return categories
end

end