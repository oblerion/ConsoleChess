
---@return Checkmate
function Checkmate()
    ---@class Checkmate
    local checkmate = {
        ---@private
        team=0,
        ---@private
        cm=false,
        ---@private
        mathcm=false,
        ---@private
        strpos=""
    }
    function checkmate:Reset()
        self.cm=false
        self.mathcm=false
        self.team=0
        self.strpos=""
    end
    ---@return boolean
    function checkmate:IfMathcheckmate()
        return self.mathcm
    end
    ---@param matrice Matrix
    ---@param players Players
    function checkmate:Update(matrice,players)
        if matrice:Checkmate(players:GetCurantTeam()) then 
            --self.players:GetPlayer(self.players.curant):SetCheckmate(true)
            if self.cm==false then
                self.team=players:GetCurantTeam()
                self.cm=true
            elseif players:GetCurantTeam()==self.team then
                self.mathcm=true
                self.strpos=matrice:Search(players:GetCurantTeam(),"roi")
            end
        end
    end
    ---@return string
    function checkmate:GetStrPos()
        return self.strpos
    end
    return checkmate
end