--[[

    Run Away Game


    Author : Can Candir
    Start Date: 02.10.2020

        Run Away is a basic game where you are a ball and you just running away from other balls. 
        If you collide with these balls u are defeated.

]]--

WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGTH = 360


push = require 'libraries/push'
Class = require 'libraries/class'
Timer = require 'libraries/knife.timer'


require 'src/StateMachine'

-- States
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'

--Classes
require 'src/Ball'
require 'src/Dummie'
require 'src/Dummies'

function love.load()      

    love.graphics.setDefaultFilter('nearest', 'nearest')

    gFonts = {

        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }

    gImages = {

        ['background'] = love.graphics.newImage('img/background_100x360.png')
    }
    love.graphics.setFont(gFonts['medium'])

    -- To obtain randomness
    math.randomseed(os.time())

    -- Title of the Game
    love.window.setTitle('Run Away')
    
    
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('start')

    -- Setup configurations for screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGTH, WINDOW_WIDTH, WINDOW_HEIGTH, {

        fullscreen = false,
        resizable = true,
        vsync = true
    })


    love.keyboard.keysPressed = {}
end


-- Resize with push library
function love.resize(w,h)

    push:resize(w,h)

end


function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if key == 'escape' then

        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)

    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end