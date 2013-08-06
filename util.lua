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


--TODO:BOUNDING BOX in checkNBD so that cells are dynamically allocated
--memory (i.e. 'false' instead of nil) as cell selection increases outward


local CF = require 'conf'
local UT = {}
local N = math.pow(CF.wd / CF.size, 2)


function UT.createGrid(x, y, wd, ht)
    local newGrid = {}
    for i = x or 1, wd or N do
        newGrid[i] = {}
        for j = y or 1, ht or N do
            newGrid[i][j] = nil
        end
    end
    return newGrid
end

--Determines which cell to fill in based on mouse position 
function UT.cellRound(x, y)
    ones = x % 10
    x = x - ones
    for i = 0, CF.size, 10 do
        if (x - i)  % CF.size == 0 then 
            x = x - i 
            break
        end
    end

    ones = y % 10
    y = y - ones
    for i = 0, CF.size, 10 do
        if (y - i) % CF.size == 0 then
           y = y - i
           break
        end
    end

    return x, y
end

--Draws the grid
function UT.loadGrid()
    --draws grid
    for i = 0, CF.wd, CF.size do 
        love.graphics.line(i, 0, i, CF.wd)
        love.graphics.line(0, i, CF.wd, i)
    end

    --draws a box around the grid
    love.graphics.rectangle("line", 0, 0, CF.wd, CF.ht)
end


--Steps Life
function UT.step(currentGrid)
    local minX, minY = CF.wd + 1, CF.wd + 1
    local maxX, maxY = 0, 0

    --Find the box surrounding all alive cells
    for k, v in pairs(currentGrid) do
        for i, j in pairs(v) do
            if k <= minX then minX = k end
            if i <= minY then minY = i end
            if k >= maxX then maxX = k end
            if i >= maxY then maxY = i end
        end
    end
 
    minX, minY = minX - 1, minY - 1
    maxX, maxY = maxX + 1, maxY + 1
   
    if minX < 0 then minX = 0 end
    if minY < 0 then minY = 0 end
    if maxX > CF.wd then maxX = CF.wd end
    if maxY > CF.ht then maxY = CF.ht end

    --Allocate values for everything in the box
    for i = minX, maxX do
        for j = minY, maxY do
            if(not currentGrid[i][j]) then
                currentGrid[i][j] = false
            end
        end

    end
        
    --Step
    local newGrid = {}
    for k, v in pairs(currentGrid) do
        newGrid[k] = {}
        for i, j in pairs(v) do
            if(checkNBD(k, i, currentGrid)) then 
                newGrid[k][i] = 1
            end
        end
    end

    currentGrid = nil
    return newGrid
end


--Scans the neighborhood
function checkNBD(x, y, grid)
    local aliveCnt = 0
   
    --checks neighborhood of 8 squares
    if(x+1 <= CF.wd and grid[x+1][y]) then aliveCnt = aliveCnt + 1 end 
    if(y - 1 > 0 and grid[x][y-1]) then aliveCnt = aliveCnt + 1 end 
    if(x - 1 > 0 and grid[x-1][y]) then aliveCnt = aliveCnt + 1 end
    if(y + 1 <= CF.wd and grid[x][y+1]) then aliveCnt = aliveCnt + 1 end 

    if(x+1 <= CF.wd and y - 1 > 0 and grid[x+1][y-1]) then 
        aliveCnt = aliveCnt + 1 
    end
        
    if(x - 1 > 0 and y - 1 > 0 and grid[x-1][y-1]) then 
        aliveCnt = aliveCnt + 1 
    end 
       
    if(x - 1 > 0 and y + 1 <= CF.wd and grid[x-1][y+1]) then 
        aliveCnt = aliveCnt + 1 
    end
      
    if(x + 1 <= CF.wd and y + 1 <= CF.wd and grid[x+1][y+1]) then 
        aliveCnt = aliveCnt + 1 
    end

    --is grid[x][y] alive or dead?
    if(grid[x][y]) then
        if aliveCnt == 2 or aliveCnt == 3 then
            return true
        else
            return false
        end
    else
        if aliveCnt == 3 then
            return true
        end
    end
end

function UT.clear(grid)
    for i = 1, N do 
        grid[i] = {}
        for j = 1, N do
            grid[i][j] = nil
        end
    end
end

return UT
