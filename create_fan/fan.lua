local function get_slot_item_count(slot_id)
    local previously_selected_slot = turtle.getSelectedSlot()
    turtle.select(slot_id)
    local stack_size = turtle.getItemCount()
    turtle.select(previously_selected_slot)
    return stack_size
end

local function calculate_processing_time(slot_id, number_of_fans)
    -- processing time specified by https://create.fandom.com/wiki/Encased_Fan
    local stack_size = get_slot_item_count(slot_id)
    local time_multiplyer = 7.5 / number_of_fans
    return math.ceil(math.ceil(stack_size / 16) * time_multiplyer + 1) -- + 1 second to accomodate for tick time errors
end

local function process_slot(slot_id, processing_time)
    local previously_selected_slot = turtle.getSelectedSlot()
    turtle.select(slot_id)
    local stack_size = get_slot_item_count(slot_id)
    turtle.drop(stack_size)
    sleep(processing_time)
    for i = 1, 10, 1 do -- empty machines whole inventory
        turtle.suck(64)
        turtle.dropDown(64)
    end
    turtle.select(previously_selected_slot)
end

local function main()
    local items_in_inventory = false
    local number_of_fans = 3
    while true do
        local slot_id = 1
        turtle.select(slot_id)
        items_in_inventory = turtle.suckUp(64)
        if items_in_inventory then
            local slot_processing_time = calculate_processing_time(slot_id, number_of_fans)
            print("estimated processing time is: "..tostring(slot_processing_time))
            process_slot(slot_id, slot_processing_time)
        end
    end
end

main()