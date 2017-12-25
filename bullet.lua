local Bullet = Object:extend()

local speed = 800
local radius = 10

function Bullet:new(x, y, dir)
    self.x = x
    self.y = y
    self.xSpeed = 0
    self.ySpeed = 0
    if dir == "up" then
        self.ySpeed = -speed
    elseif dir == "right" then
        self.xSpeed = speed
    elseif dir == "down" then
        self.ySpeed = speed
    elseif dir == "left" then
        self.xSpeed = -speed
    else
        error("not a valid diretion")
    end
end

function Bullet:update(dt)
    self.x = self.x + (self.xSpeed * dt)
    self.y = self.y + (self.ySpeed * dt)
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, radius)
end

return Bullet
