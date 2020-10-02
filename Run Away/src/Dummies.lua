--[[

    Dummies
]]--

Dummies = Class{}

function Dummies:init(dummies)

    self.dummies = dummies
end


function Dummies:update(dt)

end

function Dummies:collides(object)

end

function Dummies:render()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1,1,1,1)

    for dummy in self.dummies do
        
        love.graphics.setColor(math.random(0 , 1), math.random(0, 1), math.random(0, 1),1)
        love.graphics.circle('fill' ,self.x, self.y, self.radius)
    end

end