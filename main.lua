WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

push = require 'push'
class = require 'class'

require 'Pusheen'
require 'Pipe'

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local pusheen = Pusheen()

function love.load()
    -- So images increase in size without smoothing.
    -- 'nearest' means to use the nearest neighbor filter
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  love.window.setTitle('Flappy Pusheen')

    -- initialise window with virtual resolution
    -- altered for use of push: Takes in 4 agruments instead of two
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {
        fullscreen = false,
        vsync = true,
        resizable = true
    })     
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
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
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
    pusheen:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()

    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT -16)
    
    pusheen:render()

    push:finish()


end