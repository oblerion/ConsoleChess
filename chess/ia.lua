

--@class Ia
--local ia = {}
---@param matrix Matrix
---@param team integer
function Ia_Stupid(matrix,team)
    local moves = matrix:GetAllMoves(team)
    if #moves>0 then
        local rdm = math.random(1,#moves)
        matrix:Move(moves[rdm].x,moves[rdm].y,moves[rdm].x2,moves[rdm].y2)
    end
end