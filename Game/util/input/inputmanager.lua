require('util/input/gamepadstate')
require('util/input/inputhandler')
require('util/input/emulatedgamepad')

InputManager = Object:extend()

function InputManager:new()

  self.gamepadStates = {}
  self.connectedGamepads = {}
  self.HandlerStack = Stack()
--  self.HandlerStack:push(AssertiveInputHandler())
  self.HandlerStack:push(InputHandler())

  for i,config in ipairs(gamepadEmulationConfig) do
    local emulation = EmulatedGamePad(config.identifier)
    self:addGamepad(emulation)
  end
end

function InputManager:restart()
  self.HandlerStack = Stack()
--  self.HandlerStack:push(AssertiveInputHandler())
  self.HandlerStack:push(InputHandler())
end


function InputManager:addGamepad(joystick)

  self.gamepadStates[joystick:getID()] = GamepadState()
  self.connectedGamepads[joystick:getID()] = joystick --we need to store it here so it outlives a new InputManager instance...

end 

function InputManager:removeGamepad(joystick)

  self.gamepadStates[joystick:getID()] = nil
  for i, gamepad in ipairs(self.connectedGamepads) do 

    if gamepad:getID() == joystick:getID() then 
      table.remove(self.connectedGamepads, i)
    end
  end

end 

function InputManager:getGamepads()
  return self.connectedGamepads 
end 

function InputManager:OnPress(joystick, button)
  local offset = 0
  local handled = false
  while handled == false do
    local handler = self.HandlerStack:peek(offset)
    local inputs = handler:AllowedInputDevices()
    local allowed = false
    for k,v in pairs(inputs) do
      if v == joystick:getID() then
        allowed = true
      end
    end
    if allowed then
      handler:OnPress(joystick, button)
      handled = true
    else 
      offset = offset + 1
    end
  end
end

function InputManager:OnRelease(joystick, button)
  local offset = 0
  local handled = false
  while handled == false do
    local handler = self.HandlerStack:peek(offset)
    local inputs = handler:AllowedInputDevices()
    local allowed = false
    for k,v in pairs(inputs) do
      if v == joystick:getID() then
        allowed = true
      end
    end
    if allowed then
      handler:OnRelease(joystick, button)
      handled = true
    else 
      offset = offset + 1
    end
  end
end

--keyboard Input

function love.keyreleased( key, scancode )
  for i,config in ipairs(gamepadEmulationConfig) do
    if config.keys[key] ~= nil then
      local joystick = inputManager.connectedGamepads[config.identifier]
      love.gamepadreleased(joystick,config.keys[key])
    end
  end
end 

function love.keypressed(key, scancode, isrepeat)
  if key == "q" then love.event.quit() end

  for i,config in ipairs(gamepadEmulationConfig) do
    if config.keys[key] ~= nil then
      local joystick = inputManager.connectedGamepads[config.identifier]
      love.gamepadpressed(joystick,config.keys[key])
    end
  end
end

--gamepad Input
function love.joystickadded( joystick )

  if inputManager ==  nil then return end

  local isGamepad = joystick:isGamepad()
  if isGamepad then 

    inputManager:addGamepad(joystick)    

  end
end 

function love.joystickremoved(joystick)
  if inputManager ==  nil then return end
  local isGamepad = joystick:isGamepad()
  if isGamepad then 

    inputManager:removeGamepad(joystick)    

  end

end

function love.gamepadpressed( joystick, button )

  local isGamepad = joystick:isGamepad()
  if isGamepad then 
    if not inputManager.gamepadStates[joystick:getID()] then
      inputManager.gamepadStates[joystick:getID()] = GamepadState()
    end
    if inputManager.gamepadStates[joystick:getID()]:isReleased(button) then
      inputManager.gamepadStates[joystick:getID()]:press(button)
      inputManager:OnPress(joystick, button)
    end
  end

end

function love.gamepadreleased( joystick, button )

  local isGamepad = joystick:isGamepad()
  if isGamepad then
    if not inputManager.gamepadStates[joystick:getID()] then
      inputManager.gamepadStates[joystick:getID()] = GamepadState()
    end
    if inputManager.gamepadStates[joystick:getID()]:isPressed(button) then
      inputManager.gamepadStates[joystick:getID()]:release(button)
      inputManager:OnRelease(joystick, button)
    end
  end
end
