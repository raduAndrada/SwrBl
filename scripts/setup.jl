#!/usr/bin/env julia

using Pkg

function setup_workspace()
    # Activate parent project
    Pkg.activate(".")
    
    # Develop all child projects
A    # Pkg.develop(path = "../SwrCommonModel")
    Pkg.develop(path = "../SwrDishes")
    
    # Instantiate dependencies
    Pkg.instantiate()
    
    println("Workspace setup complete!")
end

setup_workspace()