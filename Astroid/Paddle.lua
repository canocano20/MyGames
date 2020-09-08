--[[
    Paddle Class

]]--

Paddle = Class{}



function Paddle:init(x, y , width, height)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.PADDLE_SPEED = 1000
end

function Paddle:update(dt)

    if love.keyboard.isDown('right') then

        self.x = math.min(WINDOW_WIDTH - self.width - 200  ,self.x + self.PADDLE_SPEED * dt)
    end
    if love.keyboard.isDown('left') then

        self.x = math.max(200, self.x + -self.PADDLE_SPEED * dt)
    end

    
end 

function Paddle:render()    

    love.graphics.rectangle('fill' , self.x, self.y, self.width, self.height)
end
