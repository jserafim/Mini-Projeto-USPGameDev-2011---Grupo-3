require "class.lua"
require "drawable.lua"
require "updatable.lua"

BasicWeapon = 
{
	directionX = 10,
	directionY = 0,
	collection,
	removeCollection
}

BasicWeaponBuilder = createClass(BasicWeapon, Updatable, Drawable)

function BasicWeapon:new()
	self.collection[#self.collection+1] = self
end

function BasicWeapon:destroy()
	self.removeCollection[#self.removeCollection+1] = self
end

function BasicWeapon:update(dt)
	self.x = self.x + self.directionX
	self.y = self.y + self.directionY
	
	if not self:isOnScreen() then 
		BasicWeaponBuilder:destroy(self)
	end
end

function BasicWeapon:collide()
	BasicWeaponBuilder:destroy(self)
end
