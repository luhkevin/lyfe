--[[
--Utility library for lyfe. Contains various math functions
--and cellular automata helper functions
]]--

--Returns draw position of the cell based on x,y coordinates
local UT = {}

UT.wd, UT.ht = 600, 600
UT.size = 20
UT.grid = {} 

local N = math.pow(UT.wd / UT.size, 2)

function UT.createGrid()
    for i = 1, N do
        UT.grid[i] = {}
        for j = 1, N do
            UT.grid[i][j] = false
        end
    end
    return UT.grid
end

function UT.roundForty(x, y)
    ones = x % 10
    x = x - ones
    for i = 0, UT.size, 10 do
        if (x - i)  % UT.size == 0 then 
            x = x - i 
            break
        else
        end
    end

    ones = y % 10
    y = y - ones
    for i = 0, UT.size, 10 do
        if (y - i) % UT.size == 0 then
           y = y - i
            break
        end
    end

    return x, y
end

function UT.loadGrid()
    --love.graphics.print('LYFE', 150, 150)
    
    --draws vertical lines
    for i = 0, UT.wd, UT.size do 
        love.graphics.line(i, 0, i, UT.wd)
    end

    --draws horizontal lines
    for j = 0, UT.wd, UT.size do
        love.graphics.line(0, j, UT.wd, j)
    end

    --draws a box
    love.graphics.rectangle("line", 0, 0, UT.wd, UT.ht)
end

--steps Life
function UT.step()
    local tempGrid = {}

    for i = 1, N do 
        tempGrid[i] = {}
        for j = 1, N do
            tempGrid[i][j] = false
        end
    end   

    for k, v in ipairs(UT.grid) do
        for i, j in ipairs(v) do
            if(checkNBD(k, i)) then 
                tempGrid[k][i] = 1
            end
        end
    end

    for k, v in ipairs(UT.grid) do
        for i, j in ipairs(v) do
            UT.grid[k][i] = tempGrid[k][i]
        end
    end
end

--scans the neighborhood
function checkNBD(x, y)
    local aliveCnt = 0
    

    if(x+1 <= UT.wd and grid[x+1][y]) then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(x+1 <= UT.wd and y - 1 > 0  and grid[x+1][y-1]) then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(y - 1 > 0 and grid[x][y-1])    then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(x - 1 > 0 and y - 1 > 0 and grid[x-1][y-1]) then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(x - 1 > 0 and grid[x-1][y])    then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(x - 1 > 0 and y + 1 <= UT.wd and grid[x-1][y+1]) then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(y + 1 <= UT.wd and grid[x][y+1]) then 
        aliveCnt = aliveCnt + 1 
    end
    
    if(x + 1 <= UT.wd and y + 1 <= UT.wd and grid[x+1][y+1]) then 
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
