let
    pts = [rand(Point{2,Float64}) for i in 1:10]
    rect = GeometryBasics.Rect(Vec2(0.0,0.0),Vec2(1.0,1.0))
    controller = voronoi_controller(pts,rect)
    pts = pts .+ get_vels(controller)
    update_controller!(controller,pts)
end