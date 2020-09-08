Ball = Class{}

-- Initilization of ball
function Ball:init(width, heigth, x, y)
    self.width = width
    self.heigth = heigth
    self.x = x
    self.y = y

    self.dx = math.random(2) == 1 and 200 or -200
    self.dy = math.random(-50, 50)
end

function Ball:reset()

    -- Reset Ball in the center
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGTH / 2 - 2

    -- New random 
    self.dx = math.random(2) == 1 and 200 or -200
    self.dy = math.random(-50, 50)
end

-- Update ball position with dt
function Ball:update(dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

-- Render Ball
function Ball:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width , self.heigth)
end