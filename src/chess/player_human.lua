require "chess.input"
require "chess.player"

local piece_moves = require "chess.piece_moves"

---@param team integer
---@return Player_human
function Player_human(team)
    ---@class Player_human : Player
    local player_human = Player(team,"human")

    ---@param chess Chess
    ---@return boolean
    function player_human:Update(chess)
       return chess:SelectHuman()
    end
    return player_human
end