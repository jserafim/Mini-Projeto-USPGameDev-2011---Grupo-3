require "player.lua"
--require "background.lua"
require "collisionmanager.lua"
require "enemy.lua"
require "basicplatform.lua"
require "physics.lua"

function love.load()
    love.filesystem.setIdentity("platformerprototype1")
    
    love.graphics.setMode(800, 600, false, true, 0)
    love.graphics.setCaption("Platformer Prototype")

    CollisionManager = CollisionManagerBuilder:new()

    platform1 = BasicPlatformBuilder:new(
    {
        x = 50,
        y = 470,
        z = 3,
        width = 70,
        height = 10
    }
    )

    enemy = EnemyBuilder:new(
    {
        image = love.graphics.newImage("assets/enemy.png"),
        x = 400,
        y = 330,
        z = 11
    }
    )

    --[[background = BackgroundBuilder:new(
		{
			backgrounds = 
			{
				DrawableBuilder:new({image = love.graphics.newImage("background.png")}),
				DrawableBuilder:new({image = love.graphics.newImage("background2.png")}),
				DrawableBuilder:new({image = love.graphics.newImage("background3.png")})
			}
		}
	)]]

	player = PlayerBuilder:new(
		{
			image = love.graphics.newImage("assets/player.png"),
			x = 172,
			y = 340,
            z = 10
		}
	)

	DrawableBuilder:new({image = love.graphics.newImage("assets/background.png"),
                         z = 1})

    CollisionManager:addCollisionTables({player}, enemyList)
    CollisionManager:addCollisionTables({player}, {platform1})
    CollisionManager:addCollisionTables(playerWeaponsList, enemyList)

    physics = PhysicsBuilder:new()
end

function love.draw()
	for i=1, # drawableList do 
		drawableList[i]:draw() 
	end
end

function love.update(dt)
	for i=1, # updatableList do 
		updatableList[i]:update(dt) 
	end
    removeItems(updateListRemove, updatableList)
    removeItems(drawableListRemove, drawableList)
    removeItems(enemyListRemove, enemyList)
    removeItems(playerWeaponsListRemove, playerWeaponsList)
    removeItems(physObjListRemove, physicalobject)
end

function removeItems(itemsToRemove, source)
    for i=1, #itemsToRemove do
        for j=1, #source do
            if source[j] == itemsToRemove[i] then
                table.remove(source, j)
                break
            end
        end
        itemsToRemove[i] = nil
    end
end
