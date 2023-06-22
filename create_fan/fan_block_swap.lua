local function init()
    print("place water bucket in slot 1")
    print("place lava bucket in slot 2")
    print("place flint & steel in the chest above the turtle")
    turtle.select(1)
end

local function reload_fire_if_needed()
    if turtle.getItemCount() == 0 then
        turtle.suckUp(1)
        if turtle.getItemCount() == 0 then
            print("gib more flint & steel")
            return false
        end
    end
    return true
end

-- cycles water, lava, fire
local function place_next_in_cycle(placed)
    if(placed == "water") then
        turtle.place()
        turtle.select(2) -- lava bucket
        turtle.place()
        return "lava"
    elseif placed == "lava" then
        turtle.place()
        turtle.select(3) -- flint & steel
        if reload_fire_if_needed() == false then
            -- failed getting flint & steel
            return "none"
        end
        turtle.place()
        return "fire"
    elseif placed == "fire" or placed == "none" then
        turtle.select(1)
        turtle.place()
        return "water"
    end
end

local function main()
    local placed = "none"
    init()
    while true do
        if redstone.getInput("back") then
            placed = place_next_in_cycle(placed)
            sleep(1)
        end
        os.pullEvent("redstone")
    end
end

main()