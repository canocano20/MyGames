--[[
     --- Astroid Game ---

    Developed by Can Candir
]]--

Class = require 'class'



require 'StateMachine'

require 'states/BaseState'
require 'states/Entrance'
require 'states/Play'
require 'states/EndGame'

require 'Paddle'
require 'Ball'
require 'Barrier'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


function love.load()

    -- Name of the Game
    love.window.setTitle('Astroid')

    -- Fonts used in Game
    defaultFontMedium = love.graphics.newFont('fonts/font.ttf',16)
    defaultFontLarge = love.graphics.newFont('fonts/font.ttf', 32)


    -- Random seed generator

    math.randomseed(os.time())


    -- State Machine states

    gStateMachine = StateMachine {

        ['entrance'] = function() return Entrance() end,
        ['play'] = function() return Play() end,
        ['endGame'] = function() return EndGame() end
    }

    gStateMachine:change('entrance')

    -- Screen Settings
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })


    -- Initilizations

    love.keyboard.keysPressed = {}

end 

function love.resize(w, h)

    WINDOW_HEIGHT = h
    WINDOW_WIDTH = w
end

function love.update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}

end




function love.keypressed(key)

    love.keyboard.keysPressed['key'] = true

    -- ESC will quit the game
    if key == 'escape' then
        love.event.quit()
    end
end


function love.keyboard.wasPressed(key)

    return love.keyboard.keysPressed['key']
end


function love.draw()

    gStateMachine:render()
    
end