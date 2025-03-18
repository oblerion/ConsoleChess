require("state.state")
function StateManager()
    ---@class StateManager
    local statemanager = {
        ---@private
        ---@type State[]
        list={},
        ---@private
        curant=1
    }
    ---@param state State
    function statemanager:AddState(state)
        table.insert(self.list,state)
        if #self.list==1 then
            self:SetCurantState(1)
        end
    end
    ---@return State
    function statemanager:GetState()
        if self.curant>0 and self.curant<=#self.list then
            return self.list[self.curant]
        end
        return State()
    end
    ---@param id integer
    function statemanager:SetCurantState(id)
        if id>0 and id<=#self.list then
            love.timer.sleep(0.2)
            self.curant=id
            self.list[self.curant]:Init()
            
        end
    end
    function statemanager:Update()
        self.list[self.curant]:Update(self)
    end
    function statemanager:Draw()
        self.list[self.curant]:Draw()
    end

    return statemanager
end
