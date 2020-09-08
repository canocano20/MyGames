--[[
    End game state

]]--


EndGame = Class{__includes = BaseState}

function EndGame:init()

    self.win = false

end

function EndGame:enter(params)

    if params.result == 'win' then
        self.win = true
    end
end


function EndGame:update(dt)

    if love.keyboard.wasPressed('space') then

        gStateMachine:change('play', {
            x = 10,
            y = 5
        })
    end
end

function EndGame:render()

    if self.win then

        love.graphics.setFont(defaultFontLarge)
        love.graphics.printf('You Won !!!!!', 0, WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')
        love.graphics.setFont(defaultFontMedium)
        love.graphics.printf('Press "space" to restart', 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
    else
        love.graphics.setFont(defaultFontLarge)
        love.graphics.printf('You Lose !!!!!', 0, WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')
        love.graphics.setFont(defaultFontMedium)
        love.graphics.printf('Press "space" to restart', 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
    end
end