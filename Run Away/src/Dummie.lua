--[[

    Dummies
]]--

Dummie = Class{}

function Dummie:init(x, y , radius)

    self.x = x
    self.y = y
    self.radius = radius

    self.dx = math.random(-150, -100)
    self.dy = math.random(-150, -100)


    self.colorRed = math.random(1, 255) / 255
    self.colorGreen = math.random(1, 255) / 255
    self.colorBlue = math.random(1, 255) / 255
end


function Dummie:update(dt)

    if self.x - self.radius < 100  then
        
        self.x = self.x + 5
        self.dx = -self.dx 

    elseif self.x + self.radius > 540 then

        self.x = self.x - 5
        self.dx = -self.dx 

    elseif self.y - self.radius < 0  then

        self.y = self.y + 5
        self.dy = -self.dy

    elseif self.y + self.radius > 360 then

        self.y = self.y - 5
        self.dy = -self.dy
    end

    self.x = self.x + dt * self.dx
    self.y = self.y + dt * self.dy

end

function Dummie:collides(object)


    if self.x < object.x and self.radius + self.x > object.x and self.y < object.y and self.y + self.radius > object.y then
        return true
    else
        return false
    end

end

function Dummie:render()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(self.colorRed, self.colorGreen ,self.colorBlue, 1)
    love.graphics.circle('fill' ,self.x, self.y, self.radius)

    love.graphics.setColor( 1,1,1,1 )
end