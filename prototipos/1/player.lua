require "class.lua"
require "drawable.lua"
require "updatable.lua"
require "basicweapon.lua"
require "physicalobject.lua"

playerWeaponsList = {}
playerWeaponsListRemove = {}

Player = 
{
	timeToNextShot = 0,
	bulletImage,
    speed = 90,
    vertSpeed = 0,
    isOnPlatform = true,
    isJumping = false,
    isFalling = false
}

PlayerBuilder = createClass(Player, PhysicalObject, Updatable, Drawable)

function Player:new()
	self.bulletImage = love.graphics.newImage("assets/bullet.png")
end

function Player:update(dt)
	self.timeToNextShot = self.timeToNextShot - dt
    
	if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("h") and not self.isJumping then
        print("jumping")
        self.isJumping = true
        self.isOnPlatform = false
        self.vertSpeed = -250
    end
	if love.keyboard.isDown(" ") and self.timeToNextShot <= 0 then
        self.timeToNextShot = 0.2

        BasicWeaponBuilder:new(
        {
            image = self.bulletImage,
            x = self.x + self.image:getWidth(),
            y = self.y + self.image:getHeight() / 2 - self.bulletImage:getHeight() / 2,
            z = self.z,
            collection = playerWeaponsList,
            removeCollection = playerWeaponsListRemove
        }
        )
	end
    self.y = self.y + self.vertSpeed * dt
    if not self.isOnPlatform then
        self.vertSpeed = self.vertSpeed + 250 * dt
    end
end

function Player:collide(other)
    if other.getClassName and other.getClassName() == "BasicPlatform" then
        self.isOnPlatform = true
        self.isJumping = false
        self.vertSpeed = 0
    end
end
