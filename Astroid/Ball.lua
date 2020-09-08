--[[
    Ball Class

]]--

Ball = Class{}


function Ball:init(x, y, width, height)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(30,40) / 100
    self.dy = math.random(30,35) / 100
end

function Ball:update(dt)
    
    if self.x <= 200 or self.x >= WINDOW_WIDTH - 200 - self.width then
        self.dx = -self.dx
    end

    if self.y < 0 then
        self.dy = -self.dy
    end

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end 

function Ball:collision(smth)

    if self.x + self.width > smth.x and self.x < smth.x + smth.width and self.y + self.height > smth.y and self.y < smth.y + smth.height then
        return true
    else
        return false
    end
    

end


function Ball:render()
    
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
