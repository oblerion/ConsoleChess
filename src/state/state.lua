
---@return State
function State()
    ---@class State
    local state = {}
    function state:Init()
    end
    ---@param statemanager StateManager
    function state:Update(statemanager)
    end
    function state:Draw()
    end
    return state
end