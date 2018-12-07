
# cf notebook for details

function get_TTC(ego::Vector{Float64}, obj::Vector{Float64}, radius::Float64)
    x1 = ego[1] ; y1 = ego[2]; vx1 = ego[3]; vy1 = ego[4]
    x2 = obj[1] ; y2 = obj[2]; vx2 = obj[3]; vy2 = obj[4]
            
    a = (vx1 - vx2)^2 + (vy1 - vy2)^2
    b = 2 * ((x1 - x2) * (vx1 - vx2) + (y1 - y2) * (vy1 - vy2))
    c = (x1 - x2)^2 + (y1 - y2)^2 - radius^2
        
    if a == 0 && b == 0
        if c == 0
            return 0
        else
            return Inf
        end
    end
    
    if a == 0 && b != 0
        t = -c/b
        if t < 0
            return Inf
        else
            return t
        end
    end
    
    Δ = b^2 - 4*a*c
    if Δ < 0
        return Inf
    end
    
    t1 = (-b-sqrt(Δ))/(2*a)
    t2 = (-b+sqrt(Δ))/(2*a)  
    if t1 < 0
        t1 = Inf
    end
    
    if t2 < 0
        t2 = Inf
    end
    
    return min(t1, t2)    
end


function get_smallest_TTC(s::Vector{Float64})
    radius = 15.0
    ego = s[1:4]
    
    
    smallest_TTC = Inf
    smallest_TTC_obj = -1
    
    idx = 5
    for n in 1:Int64((length(s)-4)/4)
        obj = s[idx:idx+3]
        TTC = get_TTC(ego, obj, radius)
        
        if TTC < smallest_TTC
            smallest_TTC = TTC
            smallest_TTC_obj = n
        end
        idx += 4
    end
    
    return smallest_TTC, smallest_TTC_obj
end


function get_obs_node_class_ttc1(s_ego::Vector{Float64}, o::Vector{Int})
    smallest_TTC, smallest_TTC_obj = get_smallest_TTC(vcat(s_ego, Float64.(o)))
    smallest_TTC = min(smallest_TTC, 11)
    smallest_TTC = trunc(Int, smallest_TTC)
    return (smallest_TTC)
end
