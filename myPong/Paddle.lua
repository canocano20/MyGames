Paddle = Class{}

function Paddle:init(width, heigth, x, y, speed)

    self.width = width
    self.heigth = heigth
    self.x = x
    self.y = y
    self.speed = speed
end
    
function Paddle:update(dt, direction)

    if direction == 'up' then
        self.y = math.max(0, self.y + -self.speed * dt)
    elseif direction == 'down' then
        self.y = math.min(VIRTUAL_HEIGTH - self.heigth, self.y + self.speed * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.heigth)

end