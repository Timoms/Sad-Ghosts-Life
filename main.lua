local Array2d = require "class/array2d"

function love.load()

  font = love.graphics.newFont("fonts/ARCADECLASSIC.TTF", 25)
  love.graphics.setFont(font)
  love.graphics.setBackgroundColor(0, 0, 0)

  --love.graphics.setBackgroundColor(255, 255, 255)

  bullets = 10

  array = Array2d()
  randBrick()

  hearts = 5
  level = 1
  positionX = 200
  positionY = 300

  userX = 200
  userY = 200


  playerTRL = love.graphics.newImage("visuals/player_top_rl.png")

  playerRL = love.graphics.newImage("visuals/player_rl.png")


  playerTLR = love.graphics.newImage("visuals/player_top_lr.png")

  playerLR = love.graphics.newImage("visuals/player_lr.png")


  player_dir = true
  player_top = false

  background = love.graphics.newImage("visuals/background.png")
  love.graphics.scale(0.5, 0.5)


  rock = love.graphics.newImage("visuals/rock.png")
  heart = love.graphics.newImage("visuals/heart.png")



  shooting = false
  shooting_dir = nil
  shooting_x = 0
  shooting_y = 0
  --array:set(x, y, value)
  --array:get(x, y)
end

function love.draw()

  love.graphics.draw(background, 0, 0, 0)
  love.graphics.setFont(font)
  love.graphics.print("Level " .. level, love.graphics.getWidth() - 220, 20)
  love.graphics.print("Bullets  " .. bullets, love.graphics.getWidth() - 220, 35)

  for i, row in array:iterRows() do
    --love.graphics.rectangle("fill", row[1],row[2], 20, 20)
    love.graphics.draw(rock, row[1], row[2], 0, 0.7, 0.7)

    if shooting_x == row[1] then
      shooting = false
    end

  end

  for i = 1, hearts do
    love.graphics.draw(heart, 0 + i * 25, 20, 0, 0.1, 0.1)
  end

if player_top == false then

  if (player_dir) then
    love.graphics.draw(playerRL, userX, userY, 0, 0.6, 0.6)
  elseif (player_dir == false) then
    love.graphics.draw(playerLR, userX, userY, 0, 0.6, 0.6)
  end

end

if player_top == true then

  if (player_dir) then
    love.graphics.draw(playerTRL, userX, userY, 0, 0.6, 0.6)
  elseif (player_dir == false) then
    love.graphics.draw(playerTLR, userX, userY, 0, 0.6, 0.6)
  end

end


  if shooting then

    love.graphics.circle("fill", shooting_x, shooting_y, 10)
    if shooting_dir == "left" then

      shooting_x = shooting_x - 10

    end
    if shooting_dir == "right" then

      shooting_x = shooting_x + 10

    end

    if shooting_x > love.graphics.getWidth() then
      shooting = false
    end
  end

end


function randBrick()
  for i = 1, math.random(0, 10) do
    array:set(i, 1, math.random(80, love.graphics.getWidth() - 420))
    array:set(i, 2, math.random(80, love.graphics.getHeight() - 200))
  end
end

function shoot(dir, xdir, ydir)
  if dir == "left" then

    if bullets == 0 then
      shooting = false
      return
    end

    bullets = bullets - 1
    shooting = true
    shooting_dir = "left"
    shooting_x = xdir
    shooting_y = ydir

  end

  if dir == "right" then

    if bullets == 0 then
      shooting = false
      return
    end

    bullets = bullets - 1
    shooting = true
    shooting_dir = "right"
    shooting_x = xdir
    shooting_y = ydir

  end

end

function love.keypressed(key)
   if key == "left" then
    shoot("left", userX, userY + 30)
    player_dir = true
   end
   if key == "right" then
    shoot("right", userX, userY + 30)
    player_dir = false
   end
end

function love.update(dt)


  --if positionX == userX or positionY == userY then
  --userX = userX - 100
  --userY = userY - 100
  --return
  --end
  --RIGHT BORDER
  if (userX > love.graphics.getWidth() - 385) then
    userX = userX - 1
    return
  end
  --BOTTOM BORDER
  if (userY > love.graphics.getHeight() - 80) then
    userY = userY - 1
    return
  end
  --LEFT
  if (userX < 85) then
    userX = userX + 1
    return
  end
  --TOP
  if (userY < 65) then
    userY = userY + 1
    return
  end

  if love.keyboard.isDown("escape") then
    randBrick()
  end
  if love.keyboard.isDown("r") then
    love.event.quit("restart")
  end

  if love.keyboard.isDown("w") then
    player_top = true
    userY = userY - 10
  end
  if love.keyboard.isDown("s") then
    player_top = false
    userY = userY + 10
  end
  if love.keyboard.isDown("a") then
    player_dir = true
    userX = userX - 10
  end
  if love.keyboard.isDown("d") then
    player_dir = false
    userX = userX + 10
  end
  if love.keyboard.isDown("q") then
    love.event.quit()
  end



end
