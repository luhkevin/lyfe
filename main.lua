--[[
--Game of Life Engine and Game

A Game of Life simulator and implementation of "Immigration": Two player Game of Life, each trying
to capture the most space.

A general Game of Life Engine will be implemented too, allowing developers to make their own games

]]--

local util = require 'util'
local colorCnt = 0

function love.load()
    love.graphics.setMode(util.wd, util.ht, false, true)

    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 255, 0)
    love.keyboard.setKeyRepeat(0.01, 0.25) 
    
    drawX, drawY = nil, nil
    pressed = false

    --setup grid side length
    grid = util.createGrid()
end


function love.draw()    
    util.loadGrid()
    
    --fills in the cell
    if(drawX and drawY) then 
        for k, v in ipairs(grid) do
           for i, j in ipairs(v) do 
               if(j) then
                   love.graphics.rectangle("fill", util.size*(k - 1), util.size*(i - 1),
                   util.size, util.size)
               end 
           end
        
        end
    end

end

function love.update(dt)
    if colorCnt == 0 then 
        love.graphics.setColor(0, 255, 0)
    elseif colorCnt == 1 then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(0, 0, 255)
    end
end

function love.keypressed(key)
    if key == "return" then
        util.step()
    end

    if key == "escape" then
        util.clear()
    end

    if key == 'q' then
        love.event.quit()
    end

    if key == 'tab' then
        colorCnt = (colorCnt  + 1) % 3  
    end

end


function love.mousepressed(x, y, button) 
    if button == "l" then
        drawX, drawY = util.roundForty(x, y)

        gridX = drawX / util.size + 1
        gridY = drawY / util.size + 1

        grid[gridX][gridY] = 1

    elseif button == "r" then
        drawX, drawY = util.roundForty(x, y)

        gridX = drawX / util.size + 1
        gridY = drawY / util.size + 1

        grid[gridX][gridY] = false
    end
end
