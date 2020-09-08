

push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'


WIDTH_RESULATION = 1280
HEIGTH_RESULATION = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGTH = 243

PADDLE_SPEED = 200




-- love.load is loading in the beginning of the game only.
function love.load()

    -- For good looking strings
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Game Title 
    love.window.setTitle('Pong Game')

    -- Randomness
    math.randomseed(os.time())

    -- Small Font for String
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    -- Score Font
    scoreFont = love.graphics.newFont('font.ttf', 24)

    -- Elements of Game
    player1Score = 0
    player2Score = 0

    -- Sounds
    sounds = {
        ['paddleSound'] = love.audio.newSource('sound/paddle_hit.wav', 'static'),
        ['wallSound'] = love.audio.newSource('sound/wall_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sound/score.wav', 'static')
    }

    player1 = Paddle(5, 25, 15, VIRTUAL_HEIGTH / 2 - 5, PADDLE_SPEED)
    player2 = Paddle(5, 25, VIRTUAL_WIDTH - 20, VIRTUAL_HEIGTH / 2 - 5, PADDLE_SPEED)

    ball =  Ball(4, 4, VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGTH / 2 - 2)

    -- Screen setup for virtual enviroment
    push:setupScreen (VIRTUAL_WIDTH, VIRTUAL_HEIGTH, WIDTH_RESULATION, HEIGTH_RESULATION,{

        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Game State
    gameState = 'begin'
end


function love.update(dt)

    -- Player 1 Paddle
    if love.keyboard.isDown("w") then
       player1:update(dt, 'up')

    elseif love.keyboard.isDown("s") then
        player1:update(dt, 'down')
    
    end

    -- Player 2 Paddle
    --[[
    if love.keyboard.isDown("up") then
        player2:update(dt, 'up')
    
    elseif love.keyboard.isDown("down") then
        player2:update(dt, 'down')
    end
    ]]--
    if ball.y > player2.y and math.random(2) == 1 then

        player2:update(dt,'down')

    elseif ball.y < player2.y  and math.random(2) == 1 then
        
        player2:update(dt,'up')

    end
    
    -- When State is play
    if gameState == 'play' then
        ball:update(dt)
    end

    -- When Collision occurs

    if player1.x < ball.x + ball.width and
       player1.x + player1.width > ball.x and
       player1.y < ball.y + ball.heigth and
       player1.y + player1.heigth > ball.y then

        ball.dx = -ball.dx * 1.1
        ball.dy = math.random(-120,120)
        sounds['paddleSound']:play()
    end
    
    if player2.x < ball.x + ball.width and
       player2.x + player2.width > ball.x and
       player2.y < ball.y + ball.heigth and
       player2.y + player2.heigth > ball.y then

        ball.dx = -ball.dx * 1.1
        ball.dy = math.random(-120,120)
        sounds['paddleSound']:play()
    end

    if ball.y < 0 or ball.y > VIRTUAL_HEIGTH - ball.heigth then

        ball.dy = -ball.dy
        sounds['wallSound']:play()
    end

    if ball.x < 0 then
        player2Score = player2Score + 1
        ball:reset()
        gameState = 'start'
        sounds['score']:play()

    elseif ball.x > VIRTUAL_WIDTH then
        player1Score = player1Score + 1
        ball:reset()
        gameState = 'start'
        sounds['score']:play()

    end

    if player1Score == 10 or player2Score == 5 then
        gameState = 'end'
    end
end

function love.keypressed(key)

    -- Close game with ESC button
    if key == 'escape' then
        love.event.quit()

    end

    -- Start the game with Enter button
    if key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        
    -- Reset the game with space button
        elseif player2Score == 5 or player1Score == 5 then
            
            gameState = 'end'
        
            
        end
    end

    if key == "r" then
        player1Score = 0
        player2Score = 0

        player1Y = VIRTUAL_HEIGTH / 2 - 5
        player2Y = VIRTUAL_HEIGTH / 2 - 5

        ball:reset()
        gameState = 'start'
    end

    if key == 'x' then
        gameState = 'start'

    end

end


function love.draw()

    push:apply('start')


    if gameState == 'begin' then
        love.graphics.setFont(scoreFont)
        love.graphics.clear(0,0,0,1)
        love.graphics.printf("PRESS X TO START PLAY", 0, VIRTUAL_HEIGTH / 2, VIRTUAL_WIDTH, 'center')
    
    elseif gameState == 'start' or gameState == 'end' then

        love.graphics.clear(255/255, 50/255, 50/255, 1)
        love.graphics.setFont(smallFont)
        love.graphics.printf("PRESS ENTER TO START PONG", 0, VIRTUAL_HEIGTH / 4 * 3, VIRTUAL_WIDTH, 'center')
        -- Background Color
        

        -- Left Paddle (Player 1)
        player1:render()
        -- Right Paddle (Player 2)
        player2:render()
        -- Ball
        ball:render()

        -- Pong Print
        love.graphics.setFont(smallFont)
        love.graphics.printf("Pong", 0, VIRTUAL_HEIGTH / 4, VIRTUAL_WIDTH, 'center')

        -- Scores
        love.graphics.setFont(scoreFont)
        love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 4, VIRTUAL_HEIGTH / 4)
        love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 4 * 3, VIRTUAL_HEIGTH / 4)

        -- Print FPS
        love.graphics.setFont(smallFont)
        love.graphics.setColor(0,1,0,1)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS()), VIRTUAL_WIDTH / 8, 30)
    
    elseif gameState == 'play' then

        
        -- Background Color
        love.graphics.clear(255/255, 50/255, 50/255, 1)

        -- Left Paddle (Player 1)
        player1:render()
        -- Right Paddle (Player 2)
        player2:render()
        -- Ball
        ball:render()

        -- Pong Print
        love.graphics.setFont(smallFont)
        love.graphics.printf("Pong", 0, VIRTUAL_HEIGTH / 4, VIRTUAL_WIDTH, 'center')

        -- Scores
        love.graphics.setFont(scoreFont)
        love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 4, VIRTUAL_HEIGTH / 4)
        love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 4 * 3, VIRTUAL_HEIGTH / 4)

        -- Print FPS
        love.graphics.setFont(smallFont)
        love.graphics.setColor(0,1,0,1)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS()), VIRTUAL_WIDTH / 8, 30)


    end
    if gameState == 'end' then
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf("Game Over!!", 0, VIRTUAL_HEIGTH / 2, VIRTUAL_WIDTH, 'center')
    end

    push:apply('end')
end


