--[[ 
--Configuration and settings for lyfe
]]--

local CF = {
    wd = 400, ht = 400,
    size = 20,
    color = {r = 0, g = 255, b = 0},
    delay = 0.2,
    autosize = false,
    autostep = false 
}

--Changes color based on the counter:
--0 = green; 1 = red; 2 = blue

function CF.changeColor(counter)
    if counter == 0 then 
        CF.color.r = 0
        CF.color.g = 255
        CF.color.b = 0
    elseif counter == 1 then
        CF.color.r = 255
        CF.color.g = 0
        CF.color.b = 0
    else
        CF.color.r = 0
        CF.color.g = 0
        CF.color.b = 255
    end
end

function CF.changeSize(width, height, size)
    CF.wd = width or 400
    CF.ht = height or 400
    CF.size = size or 20
end

return CF

