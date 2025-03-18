require("state.state")
require("gui.textbutton")

function StateTitle()
    ---@class StateTitle : State
    local state_title = State()

    state_title.btnbeginner = TextButton(20,120+30,"beginner",{r=1,g=1,b=1,a=1},{r=0.5,g=0.5,b=0.5,a=1})
    state_title.btnnormal = TextButton(20,120+30+state_title.btnbeginner:getHeight()+10,"normal",{r=1,g=1,b=1,a=1},{r=0.5,g=0.5,b=0.5,a=1})
    
    function state_title:Init()

    end
    ---@param statemanager StateManager
    function state_title:Update(statemanager)
        if self.btnbeginner:IfClick() then 
            statemanager:SetCurantState(2) 
            ---@class stategame : StateGame
            local stategame = statemanager:GetState()
            stategame:InitHuman(2)
            stategame:InitIa(1,1)
        end
        if self.btnnormal:IfClick() then
            statemanager:SetCurantState(2) 
            ---@class stategame : StateGame
            local stategame = statemanager:GetState()
            stategame:InitHuman(2)
            stategame:InitIa(1,2)
        end
    end

    function state_title:Draw()
        love.graphics.print("ConsoleChess",23,63,0,2)
        love.graphics.print("choose difficulty :",20,120,0,1)
        self.btnbeginner:Draw()
        self.btnnormal:Draw()

        love.graphics.print("Controls :\n-select :\n *primary click\n *one toutch"..
        "\n-deselect :\n *second click\n *double toutch"..
        "\n-reset game :\n *mouse middle button\n *third toutch",20,260)

        love.graphics.print("create by oblerion studio 2025",45,575)
        
    end

    return state_title
end