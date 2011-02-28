updatableList = {}
updateListRemove = {}

Updatable = 
{

}

function Updatable:new ()
    updatableList[#updatableList+1] = self
end

function Updatable:destroy()
    updateListRemove[#updateListRemove+1] = self
end

function Updatable:update ()
    
end
