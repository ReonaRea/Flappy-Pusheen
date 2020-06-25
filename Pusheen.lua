Pusheen = class{}

local GRAVITY = 20

function Pusheen:init()
    -- load pusheen from disk and assign her width and height
    self.image = love.graphics.newImage('pusheen.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position pusheen in the middle of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0

end

function Pusheen:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        self.dy = -5
    end

    self.y = self.y + self.dy
end

function Pusheen:render()
    love.graphics.draw(self.image, self.x, self.y)
end