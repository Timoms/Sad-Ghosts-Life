local Player = Object:extend()

local playerTRL = love.graphics.newImage("visuals/player_top_rl.png")

local playerRL = love.graphics.newImage("visuals/player_rl.png")

local playerTLR = love.graphics.newImage("visuals/player_top_lr.png")

local playerLR = love.graphics.newImage("visuals/player_lr.png")

function Player:new()
    self.x = 200
    self.y = 300
    self.direction = "right"
    self.speed = 400
end

function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - (self.speed * dt)
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - (self.speed * dt)
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + (self.speed * dt)
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + (self.speed * dt)
    end

    if self.x > love.graphics.getWidth() - 385 then
        self.x = love.graphics.getWidth() - 385
    end
    --BOTTOM BORDER
    if self.y > love.graphics.getHeight() - 80 then
        self.y = love.graphics.getHeight() - 80
    end
    --LEFT
    if self.x < 85 then
        self.x = 85
    end
    --TOP
    if self.y < 65 then
        self.y = 65
    end
end

function Player:draw()
    love.graphics.draw(playerLR, self.x, self.y, 0, 0.6, 0.6)
end

return Player
