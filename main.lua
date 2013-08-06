--[[
Copyright (c) 2013 Kevin Lu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

--TODO:Next step...remove createGrid() in load 
--and create the grid dynamically

local util = require 'util'
local CF = require 'conf'

function love.load()
    love.graphics.setMode(CF.wd, CF.ht, false, true)
    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 255, 0)
    love.keyboard.setKeyRepeat(0.01, CF.delay) 

    stepped = false
    selectBuf = {}
    colorCnt = 0
    drawX, drawY = nil, nil
    gridX, gridY = nil, nil

    --create the grid
    grid = util.createGrid()
end


function love.draw()    
    --draw Grid
    util.loadGrid()
    
    --fills in the cell
    if(drawX and drawY) then 
        for k, v in pairs(grid) do
           for i, j in pairs(v) do 
               if(j) then
                   love.graphics.rectangle("fill", CF.size*(k - 1), CF.size*(i - 1),
                   CF.size, CF.size)
               end 
           end
        
        end
    end

end

function love.keypressed(key)
    if key == "return" or key == " " then
        stepped = true
        grid = util.step(grid)
    end

    if key == "c" and (not stepped) then
        for k,v in pairs(selectBuf) do
           grid[v.x][v.y] = nil 
        end
    elseif key == "c" then
        util.clear(grid)
        stepped = false
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

        grid[gridX][gridY] = 1

        if(not stepped) then 
            selectBuf[#selectBuf + 1] = {x = gridX, y = gridY}
        end
   
    elseif button == "r" then
        drawX, drawY = util.cellRound(x, y)

        gridX = drawX / CF.size + 1
        gridY = drawY / CF.size + 1

        grid[gridX][gridY] = nil
    end
end
