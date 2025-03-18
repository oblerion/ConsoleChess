
require("type.vector")
require("chess.input")

function TextButton(x,y,text,col1,col2)
    ---@class TextButton
    local textbutton = {
        ---@private
        x=x,
        ---@private
        y=y,
        ---@private
        text=love.graphics.newText(love.graphics.getFont(),text),
        ---@private
        col1=col1,
        ---@private
        col2=col2
    }
    ---@return integer
    function textbutton:getWidth()
        return self.text:getWidth()
    end
    ---@return integer
    function textbutton:getHeight()
        return self.text:getHeight()
    end
    ---@return boolean
    function textbutton:IfSelect()
        local v = Vector(self.x,self.y,self:getWidth(),self:getHeight())
        local vmouse = Vector(Input_getX(),Input_getY(),10,10)
        local rb = false
        if v:Collide(vmouse) then
            rb=true
        end
        return rb
    end
    ---@return boolean
    function textbutton:IfClick()
        local rb = false
        if self:IfSelect() and Input_click() then 
            rb=true
        end
        return rb
    end

    function textbutton:Draw()
        if self:IfSelect() then
            love.graphics.setColor(self.col2.r,self.col2.g,self.col2.b,self.col2.a)
        else 
            love.graphics.setColor(self.col1.r,self.col1.g,self.col1.b,self.col1.a)
        end
      
        love.graphics.draw(self.text,self.x,self.y,0)
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("line",self.x,self.y,self:getWidth(),self:getHeight())
    end
    

    return textbutton
end