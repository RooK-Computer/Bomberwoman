
EmulatedGamePad = Object:extend()

function EmulatedGamePad:new(identifier)
  self.identifier = identifier
  return self
end

function EmulatedGamePad:getID()
    return self.identifier
end

function EmulatedGamePad:isGamepad()
    return true
end

gamepadEmulationConfig = {
    {
        identifier = 100,
        keys = {
            up = 'dpup',
            down = 'dpdown',
            left = 'dpleft',
            right = 'dpright',
            space = 'b'
        }
    },
    {
        identifier = 101,
        keys = {
            w = 'dpup',
            s = 'dpdown',
            a = 'dpleft',
            d = 'dpright',
            lshift = 'b'
        }
    },
    {
        identifier = 102,
        keys = {
            i = 'dpup',
            k = 'dpdown',
            j = 'dpleft',
            l = 'dpright',
            h = 'b'
        }
    },
    {
        identifier = 103,
        keys = {
            g = 'dpup',
            b = 'dpdown',
            v = 'dpleft',
            n = 'dpright',
            c = 'b'
        }
    }
}