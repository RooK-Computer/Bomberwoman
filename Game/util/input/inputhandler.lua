
InputHandler = Object:extend()

function InputHandler:new()
end

function InputHandler:AllowedInputDevices() 
    local devices = {}
    for k,v in pairs(inputManager.gamepadStates) do
        table.insert(devices,k)
    end
    return devices
end

function InputHandler:OnPress(joystick, button)
end

function InputHandler:OnRelease(joystick, button) 
end

AssertiveInputHandler = InputHandler:extend()

function AssertiveInputHandler:OnPress(joystick, button)
    error("Uncatched gamepad press event. Something is seriously wrong.",1)
end

function AssertiveInputHandler:OnRelease(joystick, button)
    error("Uncatched gamepad release event. Something is seriously wrong.",1)
end
