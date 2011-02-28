require "updatable.lua"

CollisionManager = 
{
	collisionTables = {}
}

CollisionManagerBuilder = createClass(CollisionManager, Updatable)

function CollisionManager:addCollisionTables(firstSet, secondSet)
	table.insert(self.collisionTables, {firstSet=firstSet, secondSet=secondSet})
end

function CollisionManager:update()
	for i=1,#self.collisionTables do
		for j=1,#self.collisionTables[i].firstSet do
			local firstObject = self.collisionTables[i].firstSet[j]
			for k=1,#self.collisionTables[i].secondSet do
				local secondObject = self.collisionTables[i].secondSet[k]
                -- POGPOGPOGPOGPOGPOG
				if not (firstObject.x >= secondObject.x + ((secondObject.getWidth and secondObject:getWidth()) or secondObject.image:getWidth()) or
				   firstObject.y >= secondObject.y + ((secondObject.getHeight and secondObject:getHeight()) or secondObject.image:getHeight()) or
				   secondObject.x >= firstObject.x + ((firstObject.getWidth and firstObject:getWidth()) or firstObject.image:getWidth()) or
				   secondObject.y >= firstObject.y + ((firstObject.getHeight and firstObject:getHeight()) or firstObject.image:getHeight()))
				then
					if firstObject.collide ~= nil then firstObject:collide(secondObject) end
					if secondObject.collide ~= nil then secondObject:collide(firstObject) end
				end
			end
		end
	end
end
