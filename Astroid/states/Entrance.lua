--[[
    Entrance state of the game

]]--

Entrance = Class{__includes = BaseState}

function Entrance:update(dt)

    if love.keyboard.wasPressed('x') then

        gStateMachine:change('play', {
            x = 10,
            y = 5
        })
    end
end

function Entrance:render()

    love.graphics.setFont(defaultFontLarge)
    love.graphics.printf('Welcome to Astroid Game', 0, WINDOW_HEIGHT / 3 , WINDOW_WIDTH, 'center')
    love.graphics.setFont(defaultFontMedium)
    love.graphics.printf('Press "x" to play', 0, WINDOW_HEIGHT / 8 * 5 , WINDOW_WIDTH, 'center')
end