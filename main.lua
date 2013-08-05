--[[
--Game of Life Engine and Game
--A Game of Life simulator and implementation of "Immigration": Two player Game of Life, each trying
--to capture the most space.

--A general Game of Life Engine will be implemented too, allowing developers to make their own games
]]--

local util = require 'util'
local CF = require 'conf'

function love.load()
    love.graphics.setMode(CF.wd, CF.ht, false, true)
    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 255, 0)
    love.keyboard.setKeyRepeat(0.01, 0.25) 
    
    colorCnt = 0
    drawX, drawY = nil, nil

    --create the grid
    grid = util.createGrid()
end


function love.draw()    
    --draw Grid
    util.loadGrid()
    
    --fills in the cell
    if(drawX and drawY) then 
        for k, v in ipairs(grid) do
           for i, j in ipairs(v) do 
               if(j) then
                   love.graphics.rectangle("fill", CF.size*(k - 1), CF.size*(i - 1),
                   CF.size, CF.size)
               end 
           end
        
        end
    end

end

function love.keypressed(key)
    if key == "return" then
        grid = util.step(grid)
    end

    if key == "escape" then
        util.clear()
    end

    if key == 'q' then
        love.event.quit()
    end

    if key == 'tab' then
        colorCnt = (colorCnt  + 1) % 3  
        CF.changeColor(colorCnt)
        love.graphics.setColor(CF.color.r, CF.color.g, CF.color.b)
    end

end


function love.mousepressed(x, y, button) 
    if button == "l" then
        drawX, drawY = util.cellRound(x, y)

        gridX = drawX / CF.size + 1
        gridY = drawY / CF.size + 1

        grid[gridX][gridY] = true

    elseif button == "r" then
        drawX, drawY = util.cellRound(x, y)

        gridX = drawX / CF.size + 1
        gridY = drawY / CF.size + 1

        grid[gridX][gridY] = false
    end
end
