# CentroidalVoronoiController

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://kylejbrown17.github.io/CentroidalVoronoiController.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://kylejbrown17.github.io/CentroidalVoronoiController.jl/dev)
[![Build Status](https://github.com/kylejbrown17/CentroidalVoronoiController.jl/workflows/CI/badge.svg)](https://github.com/kylejbrown17/CentroidalVoronoiController.jl/actions)

A simple implementation of the centroidal voronoi control policy. Built on top 
of [VoronoiCells.jl](https://github.com/JuliaGeometry/VoronoiCells.jl).

To install:
```@repl
] # enter package mode by typing "]"
add https://kylejbrown17.github.io/CentroidalVoronoiController.jl.git
```

Usage:

```@repl
using CentroidalVoronoiController
using GeometryBasics

rect = GeometryBasics.Rect(Vec2(0.0,0.0),Vec2(1.0,1.0)); # bounding rectangle
pts = [rand(Point{2,Float64}) for i in 1:10]; # agent positions
controller = voronoi_controller(pts,rect); # init controller
vels = get_vels(controller) # get commanded velocities for all agents
new_pts = [rand(Point{2,Float64}) for i in 1:10] # new agent positions
update_controller!(controller,new_pts);
get_vels(controller) # get the updated velocities
get_vel(controller,4) # get the velocity of agent 4 
```