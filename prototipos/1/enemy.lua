require "class.lua"
require "drawable.lua"
require "updatable.lua"

enemyList = {}
enemyListRemove = {}

Enemy = {}

EnemyBuilder = createClass(Enemy, Updatable, Drawable)

function Enemy:new()
	enemyList[#enemyList+1] = self
end

function Enemy:destroy()
	enemyListRemove[#enemyListRemove+1] = self
end

function Enemy:update()
	
end

function Enemy:collide()
	EnemyBuilder:destroy(self)
end
