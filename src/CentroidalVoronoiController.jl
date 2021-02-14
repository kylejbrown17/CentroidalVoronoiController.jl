module CentroidalVoronoiController

using VoronoiDelaunay
using VoronoiCells
using GeometryBasics
using GraphUtils

export 
    CVController,
    voronoi_controller,
    get_vel,
    get_vels,
    set_positions!,
    update_controller!
    
"""
    centroid(pts::Vector{V}) where {V<:AbstractVector}

Compute the centroid of the polygon whose vertices are defined (in ccw order) by 
`pts`.
"""
function centroid(pts::Vector{V}) where {V<:AbstractVector}
    p1 = pts[1]
    total_area = 0.0
    c = zero(V)
    for (p2,p3) in zip(pts[2:end-1],pts[3:end])
        a = GeometryBasics.area([p1,p2,p3])
        total_area += a
        c = ((total_area-a)/total_area)*c .+ (a/total_area) * (p1 .+ p2 .+ p3) / 3
    end
    c
end

mutable struct CVController
    tess::VoronoiCells.Tessellation
    vels::CachedElement{Vector{Point2{Float64}}}
end

function set_vels!(controller::CVController,vels)
    update_element!(controller.vels,vels)
    # controller.vels = vels
end
function compute_vels!(controller::CVController)
    tess = controller.tess
    vels = [centroid(cell) - pt for (cell,pt) in zip(tess.Cells,tess.Generators)]
    set_vels!(controller,vels)
end

function get_vels(controller::CVController)
    if !is_up_to_date(controller.vels)
        compute_vels!(controller)
    end
    get_element(controller.vels)
end
get_vel(controller::CVController,idx::Int) = get_vels(controller)[idx]

function set_positions!(controller::CVController,pts)
    controller.tess = voronoicells(pts,controller.tess.EnclosingRectangle)
    set_up_to_date!(controller.vels,false)
    controller.tess.Generators
end

function update_controller!(controller::CVController,pts)
    set_positions!(controller,pts)
    compute_vels!(controller)
    controller
end

function voronoi_controller(pts::Vector{Point2{Float64}},
        rect::Rectangle=Rectangle(Point2(0.0,0.0),Point2(1.0,1.0))
        )
    controller = CVController(
        voronoicells(pts,rect),
        CachedElement(map(p->zero(Point2{Float64}),pts))
    )
    compute_vels!(controller)
    controller
end
voronoi_controller(pts::Vector{Point2{Float64}},rect::GeometryBasics.Rect) = voronoi_controller(pts,convert(Rectangle,rect))
Base.convert(::Type{Rectangle},rect::GeometryBasics.Rect) = Rectangle(Point2((rect.origin .- rect.widths)...), Point2((rect.origin .+ rect.widths)...))

end
