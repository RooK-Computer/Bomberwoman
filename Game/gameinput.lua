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
    if button == "dpright" and self.player.move_x == 1 then
        self.player.move_x = 0
    end
    if button == "dpleft" and self.player.move_x == -1 then
        self.player.move_x = 0
    end
    if button == "dpup" and self.player.move_y == -1 then
        self.player.move_y = 0
    end
    if button == "dpdown" and self.player.move_y == 1 then
        self.player.move_y = 0
    end
end

function GameInput:OnPress(joystick, button)
    if self.gamepad == nil then
        local newInput = GameInput()
        newInput.gamepad = joystick:getID()
        newInput.player = UnoccupiedPlayers:pop()
        inputManager.HandlerStack:push(newInput)
        newInput:OnPress(joystick, button)
        return
    end

    if button == "dpright" then
        self.player.move_x = 1
    end
    if button == "dpleft" then
        self.player.move_x = -1
    end
    if button == "dpup" then
        self.player.move_y = -1
    end
    if button == "dpdown" then
        self.player.move_y = 1
    end
    if button == "b" then
        self.player:placeBomb()
    end
end