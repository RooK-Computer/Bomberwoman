GameInput = InputHandler:extend()

function GameInput:new()
    self.gamepad = nil
    self.player = nil
end

function GameInput:AllowedInputDevices()
    if self.gamepad == nil then 
        return GameInput.super.AllowedInputDevices(self)
    else
        return {self.gamepad}
    end
end

function GameInput:OnRelease(joystick, button)
    if self.gamepad == nil then
        local newInput = GameInput()
        newInput.gamepad = joystick:getID()
        newInput.player = UnoccupiedPlayers:pop()
        inputManager.HandlerStack:push(newInput)
        newInput:OnRelease(joystick, button)
        return
    end
    local currentPlayer = self.player
    if button == "dpright" then
        currentPlayer:moveRight()
    end
    if button == "dpleft" then
        currentPlayer:moveLeft()
    end
    if button == "dpup" then
        currentPlayer:moveUp()
    end
    if button == "dpdown" then
        currentPlayer:moveDown()
    end
    if button == "b" then
        currentPlayer:placeBomb()
    end
end