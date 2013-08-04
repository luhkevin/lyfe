--[[
--Game of Life Engine and Game

A Game of Life simulator and implementation of "Immigration": Two player Game of Life, each trying
to capture the most space.

A general Game of Life Engine will be implemented too, allowing developers to make their own games

]]--


local grid = {}
local wd, ht = 400, 400

--size of the cell
local size = 20

function love.load()
    --400 x 400, windowd, v-sync
    love.graphics.setMode(wd, ht, false, true)

    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 255, 0)
   
    --Use closures for inserting into drawBuffer?
    drawBuffer = {}
    drawX, drawY = nil, nil
    pressed = false

    --setup grid side length
    local N = math.pow(wd / size, 2)

    for i = 1, N do 
        grid[i] = {}
        for j = 1, N do
            grid[i][j] = 0
        end
    end
end


function love.draw()    
    loadGrid()

    --fills in the cell
    if(drawX and drawY) then 
        for k, v in ipairs(drawBuffer) do
            love.graphics.rectangle("fill", v.x, v.y, size, size)
        end
    end

end

function love.update()
end


function love.mousepressed(x, y, button) 
    if button == "l" then
        drawX, drawY = roundForty(x, y)
        t = {x=drawX, y=drawY}
        table.insert(drawBuffer, t)
    end 
end




--helper functions


--Returns draw position of the cell based on x,y coordinates
function roundForty(x, y)
    ones = x % 10
    x = x - ones
    for i = 0, size, 10 do
        if (x - i)  % size == 0 then 
            x = x - i 
            break
        else
        end
    end

    ones = y % 10
    y = y - ones
    for i = 0, size, 10 do
        if (y - i) % size == 0 then
            y = y - i
            break
        end
    end

    return x, y
end

function loadGrid()
    --love.graphics.print('LYFE', 150, 150)
    
    --draws vertical lines
    for i = 0, 400, size do 
        love.graphics.line(i, 0, i, 400)
    end

    --draws horizontal lines
    for j = 0, 400, size do
        love.graphics.line(0, j, 400, j)
    end

    --draws a box
    love.graphics.rectangle("line", 0, 0, 400, 400)
end
