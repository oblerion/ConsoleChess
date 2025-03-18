require("gui.textbutton")
---@param x integer
---@param y integer
---@param text string
---@param url string
---@param col1 table
---@param col2 table
function LinkButton(x,y,text,url,col1,col2)
    ---@class LinkButton : TextButton
    local linkbutton = {
        ---@private
        txtbtn = TextButton(x,y,text,col1,col2),
        ---@private
        url=url
    }
    ---@return boolean
    function linkbutton:IfClick()
        return self.txtbtn:IfClick()
    end
    function linkbutton:Draw()
        if self:IfClick() then 
            love.system.openURL(self.url)
        end
        self.txtbtn:Draw()
    end
    return linkbutton
end