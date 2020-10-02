--[[

    Play State of Run Away game

]]--

PlayState = Class{__includes = BaseState}

function PlayState:init()

    self.ball = Ball(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGTH / 2, 5, 200)
    self.timer = 0


    Timer.every(1, function()
        self.timer = self.timer + 1
    end)  

    Timer.every(5, function()
        
        if #self.dummies < 20 then
            table.insert(self.dummies, Dummie( math.random(100, 560), math.random(0, 360), math.random(2,10)))
        end
           
        self.ball.radius = self.ball.radius + 1
    end)  

    Timer.every(3, function()
        
        for k, pair in pairs(self.dummies) do

            pair.dx = pair.dx + 20
            pair.dy = pair.dy + 20
        end
    end)

    Timer.every(30, function()
    
        for k, pair in pairs(self.dummies) do

            if pair.radius > 3 then

                pair.radius = pair.radius - 2
                pair.dx = pair.dx - 50
                pair.dy = pair.dy - 50
            end
        end

        self.ball.radius = self.ball.radius - 5
    end)
end

function PlayState:enter(params)

    self.dummies = params.dummies
end 

function PlayState:update(dt)

    self.ball:update(dt)

    for k, pair in pairs(self.dummies) do
        pair:update(dt)

        if self.ball:collides(pair) then

            love.event.quit()
        end
    end

    Timer.update(dt)
end


function PlayState:render()

    love.graphics.draw(gImages['background'], 0 , 0)
    love.graphics.draw(gImages['background'], 540 , 0)

    self.ball:render()
    for k, pair in pairs(self.dummies) do

        pair:render()
    end
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0,1,0,1)
    love.graphics.print('FPS: '..love.timer.getFPS(), 20, 20)
    love.graphics.setColor(0,0,1,1)
    love.graphics.print('Time: '.. tostring(self.timer), 20, 40)
end