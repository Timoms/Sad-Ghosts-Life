require "globals"

local Array2d = require "class/array2d"
local Rock = require "rock"
local Player = require "player"
local Bullet = require "bullet"

local rocks --rock array
local bullets

function love.load()

  font = love.graphics.newFont("fonts/ARCADECLASSIC.TTF", 25)
  love.graphics.setFont(font)
  love.graphics.setBackgroundColor(0, 0, 0)

  --love.graphics.setBackgroundColor(255, 255, 255)
  player = Player()

  numberOfBullets = 10

  bullets = {}

  hearts = 5
  level = 1

  randBricks()

  background = love.graphics.newImage("visuals/background.png")
  love.graphics.scale(0.5, 0.5)

  rock = love.graphics.newImage("visuals/rock.png")
  heart = love.graphics.newImage("visuals/heart.png")
end

function randBricks()
    rocks = {}
    local rockAmount = 10
    local counter = 1
    while counter <= rockAmount do
        local x = math.random(80, love.graphics.getWidth() - 420)
        local y = math.random(80, love.graphics.getHeight() - 200)
        local rock = Rock(x, y)
        local continue = false
        for _, r in pairs(rocks) do
            if r:collidesWith(rock) then
                continue = true
                break
            end
        end
        if not continue then
          table.insert(rocks, rock)
          counter = counter + 1
        end
    end
end

function love.draw()

    love.graphics.draw(background, 0, 0, 0)
    love.graphics.setFont(font)
    love.graphics.print("Level " .. level, love.graphics.getWidth() - 220, 20)
    love.graphics.print("Bullets  " .. numberOfBullets, love.graphics.getWidth() - 220, 35)

    for _, rock in pairs(rocks) do
    rock:draw()
    end

    for i = 1, hearts do
    love.graphics.draw(heart, 0 + i * 25, 20, 0, 0.1, 0.1)
    end

    for _, b in pairs(bullets) do
        b:draw()
    end

    player:draw()

end

function love.keypressed(key)
    if key == "left" then
        if numberOfBullets > 0 then
            table.insert(bullets, Bullet(player.x, player.y, "left"))
            numberOfBullets = numberOfBullets - 1
        end
    end
    if key == "right" then
        if numberOfBullets > 0 then
            table.insert(bullets, Bullet(player.x, player.y, "right"))
            numberOfBullets = numberOfBullets - 1
        end
    end
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        randBricks()
    end
    if love.keyboard.isDown("r") then
        love.event.quit("restart")
    end
    if love.keyboard.isDown("q") then
        love.event.quit()
    end

    for _, rock in pairs(rocks) do
        if shooting_x == rock.x then
            shooting = false
        end
    end

    for _, bullet in pairs(bullets) do
        bullet:update(dt)
    end

    player:update(dt)
end
