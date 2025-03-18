require("chess.player")
local piece_moves = require "chess.piece_moves"
---@param team integer
---@param level integer
---@return Player_ia
function Player_ia(team,level)
    ---@class Player_ia : Player
    local player_ia = Player(team,"ia")
    ---@private
    player_ia.level=level
    ---@private
    ---@param matrix Matrix
    function player_ia:_stupid(matrix)
        local moves = matrix:GetAllMoves()
        if #moves < 1 then return 0 end
        for n=#moves,1,-1 do 
            if matrix:GetTeam(moves[n].x,moves[n].y)~=self:GetTeam() then
                table.remove(moves,n)
            end
        end

        if #moves>0 then
            local rdm = math.random(1,#moves)
            matrix:Move(moves[rdm].x,moves[rdm].y,moves[rdm].x2,moves[rdm].y2)
            love.timer.sleep(0.2)
        end
    end
    ---@private
    ---@param matrix Matrix
    function player_ia:_attack(matrix)
        local list = {}
        local moves = matrix:GetAllMoves()

        for _,v in pairs(moves) do
            ---@class move : Vector 
            local move = v
            local piece = matrix:GetTable(move.x,move.y)
            local piece2 = matrix:GetTable(move.x2,move.y2)
            if piece2:IfExist() and 
                piece:GetTeam()==self:GetTeam() then 
                table.insert(list,v)
            end
        end

        if #list > 0 then
            local rdm = math.random(1,#list)
            matrix:Move(list[rdm].x,list[rdm].y,list[rdm].x2,list[rdm].y2)
            love.timer.sleep(0.2)
        else  
            self:_stupid(matrix)
        end 
    end
    ---@param chess Chess
    ---@return boolean
    function player_ia:Update(chess)
        if self.level==1 then
            self:_stupid(chess.matrice)
        elseif self.level==2 then
            self:_attack(chess.matrice)
        end
        return true
    end
    return player_ia
end