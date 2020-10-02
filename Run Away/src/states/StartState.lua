--[[

    Start State of Run Away Game
]]--

StartState = Class{__includes = BaseState}

function StartState:init()

    self.start = true
    self.dummies = {}
    
end


function StartState:update(dt)

    if love.keyboard.wasPressed('x') then

        for i = 1, 5 do

            table.insert(self.dummies, Dummie( math.random(100, 560), math.random(0, 360), math.random(2,10)))
        end

        gStateMachine:change('play', {

            dummies = self.dummies
        })
    end

end



function StartState:render()

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Welcome to Run Away', 0 , VIRTUAL_HEIGTH / 3 , VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press "x" to play', 0 , VIRTUAL_HEIGTH / 2, VIRTUAL_WIDTH, 'center')
end