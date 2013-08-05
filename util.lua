--[[
--Utility library for lyfe. Contains various math functions
--and cellular automata helper functions
]]--

local CF = require 'conf'
local UT = {}
local N = math.pow(CF.wd / CF.size, 2)


function UT.createGrid()
    local newGrid = {}
    for i = 1, N do
        newGrid[i] = {}
        for j = 1, N do
            newGrid[i][j] = false
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
    local newGrid = UT.createGrid()

    for k, v in ipairs(currentGrid) do
        for i, j in ipairs(v) do
            if(checkNBD(k, i, currentGrid)) then 
                newGrid[k][i] = true
            end
        end
    end

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

function UT.clear()
    for i = 1, N do 
        grid[i] = {}
        for j = 1, N do
            grid[i][j] = false
        end
    end
end

return UT
