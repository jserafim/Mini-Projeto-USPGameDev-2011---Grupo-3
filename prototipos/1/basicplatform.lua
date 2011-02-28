require "class.lua"
require "drawable.lua"

BasicPlatform =
{
    image = love.graphics.newImage("assets/platform.png")
--[[    width = 10,
    height = 5]]
}

BasicPlatformBuilder = createClass(BasicPlatform, Drawable)

--[[function BasicPlatform:getWidth()
    return self.width
end

function BasicPlatform:getHeight()
    return self.height
end]]

function BasicPlatform:getClassName()
    return "BasicPlatform"
end
