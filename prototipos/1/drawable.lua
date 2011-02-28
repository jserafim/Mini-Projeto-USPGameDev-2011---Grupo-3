drawableList = {}
drawableListRemove = {}

Drawable =
{
    x = 0,
    y = 0,
    z = 0,
    image = nil
}

DrawableBuilder = createClass(Drawable)

function Drawable:new()
    drawableList[#drawableList+1] = self
    table.sort(drawableList, function(a, b)
                                 return a.z < b.z
                             end)
end

function Drawable:destroy()
    drawableListRemove[#drawableListRemove+1] = self
end

function Drawable:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, 0, 0)
end

function Drawable:isOnScreen()
	return not (self.x > love.graphics.getWidth() or
		self.x < -self.image:getWidth() or
		self.y > love.graphics.getHeight() or
		self.y < -self.image:getHeight())
end
