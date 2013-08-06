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

local CF = {
    wd = 800, ht = 800,
    size = 10,
    color = {r = 0, g = 255, b = 0},
    delay = 0.1,
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
