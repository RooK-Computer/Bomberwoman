
GamepadState = Object:extend()

function GamepadState:new()
  self.keys={}
end

function GamepadState:press(button)
  self.keys[button]=true
end

function GamepadState:release(button)
  self.keys[button]=false
end

function GamepadState:isPressed(button)
  if self.keys[button] ~= nil then
    return self.keys[button]
  end
  return false
end

function GamepadState:isReleased(button)
  if self.keys[button] ~= nil then
    return not self.keys[button]
  end
  return true
end

