Ball = Class{}

function Ball:init(x, y, radius, speed)

    self.x = x
    self.y = y
    self.radius = radius

    self.speed = speed

end


function Ball:update(dt)

    if love.keyboard.isDown('a') then

        self.x = math.max( 100 + self.radius, self.x - dt * self.speed)
    elseif love.keyboard.isDown('d') then
        self.x = math.min( 540 - self.radius ,self.x + dt * self.speed)
    end

    if love.keyboard.isDown('w') then
        self.y = math.max(0 + self.radius, self.y - dt * self.speed)

    elseif love.keyboard.isDown('s') then
        self.y = math.min(360 - self.radius ,self.y + dt * self.speed)

    end
end

function Ball:collides(object)


    if  self.x < object.x + object.radius and self.radius + self.x > object.x and self.y < object.y + object.radius and self.y + self.radius > object.y then
        return true
    else
        return false
    end


end

function Ball:render()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.circle('fill' ,self.x, self.y, self.radius)
end