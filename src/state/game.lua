require("state.state")
require("gui.textbutton")

---@return StateGame
function StateGame()
    ---@class StateGame : State
    local state_game = State()

    state_game.btnback = TextButton(10,320,"back",{r=1,g=1,b=1,a=1},{r=0.5,g=0.5,b=0.5,a=1})

    ---@class chess : Chess
    state_game.chess = require("chess")

    function state_game:Init()
        self.chess:Init()
        self.chess.selector:Deselect()
    end
    ---@param team integer
    ---@param level integer
    function state_game:InitIa(team,level)
        self.chess.players:AddIa(team,level)
    end
    function state_game:InitHuman(team)
        self.chess.players:AddHuman(team)
    end
    ---@param statemanager StateManager
    function state_game:Update(statemanager)
        if self.btnback:IfClick() then 
            statemanager:SetCurantState(1)
        end
    end

    function state_game:Draw()
        --love.graphics.print("game",23,23)
        self.chess:Draw()
        self.btnback:Draw()
        if self.chess.checkmate:IfMathcheckmate() then 
            love.graphics.print("checkmate in "..self.chess.checkmate:GetStrPos(),20,150)
        end
    end
    return state_game
end