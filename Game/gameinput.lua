GameInput = InputHandler:extend()

function GameInput:new()
end

function GameInput:OnRelease(joystick, button)
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