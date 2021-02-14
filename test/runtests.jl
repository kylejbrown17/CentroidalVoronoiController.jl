using CentroidalVoronoiController
using GeometryBasics
using Test

@testset "CentroidalVoronoiController.jl" begin
    # Write your tests here.
    @testset "CentroidalVoronoiController.ControllerTests" begin
        include("test_controller.jl")
    end
end
