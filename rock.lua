local Rock = Object:extend()

local rockImage = love.graphics.newImage("visuals/rock.png")
local rockWidth, rockHeight = 50, 50  --to be adjusted
local imageWidth, imageHeight = rockImage:getDimensions()

local scaleX, scaleY = rockWidth / imageWidth, rockHeight / imageHeight

local CheckCollision

function Rock:new(x, y)
  self.x = x
  self.y = y
end

function Rock:draw()
  love.graphics.draw(rockImage, self.x, self.y, 0, scaleX, scaleY)
end

function Rock:collidesWith(other)
  return CheckCollision(self.x, self.y, rockWidth, rockHeight, other.x, other.y, rockWidth, rockHeight)
end

function Rock:collidesWithPoint(x, y)
  return CheckCollision(self.x, self.y, rockWidth, rockHeight, x, y, 1, 1)
end


-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

return Rock
