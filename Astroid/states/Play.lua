--[[
    Play State

]]-- 

backgroundImg = love.graphics.newImage('img/background.png')

Play = Class{__includes = BaseState}

function Play:init()

    self.Paddle = Paddle(WINDOW_WIDTH / 2 - 37, WINDOW_HEIGHT / 12 * 11, 75, 12)
    self.Ball = Ball(WINDOW_WIDTH / 2 - 4, WINDOW_HEIGHT / 2 - 4, 8, 8)
    self.Barriers = {}

end

function Play:update(dt)


    -- Win/Lose conditions

    if self.Ball.y > WINDOW_HEIGHT  then


        gStateMachine:change('endGame', {
            result = 'lose'
        })
    elseif #self.Barriers == 0 then

        gStateMachine:change('endGame', {
            result = 'win'
        })
    end
    
    -- Ball collision with Paddle
    if self.Ball:collision(self.Paddle) then
	
		self.Ball.y = self.Paddle.y - 8
        self.Ball.dy = -self.Ball.dy
    end

    -- Ball Collision with Barriers
    for i , barrier in pairs(self.Barriers) do

        if self.Ball:collision(barrier) then
            
            self.Ball.dy = - self.Ball.dy

            table.remove(self.Barriers, i)
        end
    end

    self.Paddle:update(dt)
    self.Ball:update(dt)
end

-- Create bunch of barriers depending on parameters giving from previous state
function Play:enter(params)
    for i = 1, params.x do
        for j = 1,params.y do
            table.insert(self.Barriers, Barrier(328 + i * 58, 150 + j * 14  , 50, 10))
        end
    end

end

function Play:render()

    -- Render all created barriers for that level
    for j, barrier in  pairs(self.Barriers) do
        barrier:render()
    end
	
    love.graphics.draw(backgroundImg, 0, 0)
    love.graphics.draw(backgroundImg, WINDOW_WIDTH - 200, 0)
    love.graphics.setFont(defaultFontMedium)
    love.graphics.printf('Play State', 0, WINDOW_HEIGHT / 6, WINDOW_WIDTH, 'center')
    --love.graphics.print('selfx'..tostring(self.Ball.x), 300, 300)
    --love.graphics.print('selfy'..tostring(self.Ball.y), 300, 400)
    self.Paddle:render()
    self.Ball:render()
end