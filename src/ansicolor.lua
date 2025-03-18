---@return Ansicolor
function Ansicolor()
    ---@class Ansicolor
    local ansicolor = {
        ---@private
        color={},
        ---@private
        sys={},
        ---@private
        ctext={},
        ---@private
        cbkg={}
    }
    ---@private
    ---@param value integer
    ---@param colormt Colormt
    ---@return table
    local function makecolor(value,colormt)
        return setmetatable({ value = string.char(27) .. '[' .. tostring(value) .. 'm' }, colormt)
    end

    ---@private
    ---@class Colormt
    local colormt = {
        __metatable = {},
        __tostring = function(self)
            return self.value
        end,
        __concat = function(self,other)
            return tostring(self) .. tostring(other)
        end,
        __calls = function(self,s)
            return self .. s .. makecolor(0,self)
        end
    }
    ---@private
    local colors = {
        -- sys / attributes
        reset = 0,
        clear = 0, -- none effet
        bright = 1,
        dim = 2,
        underscore = 4,
        blink = 5,
        reverse = 7,
        hidden = 8,

        -- text color / foreground
        black = 30,
        red = 31,
        green = 32,
        yellow = 33,
        blue = 34,
        magenta = 35,
        cyan = 36,
        li_gray = 37,
        gray = 90,
        white = 97,

        -- background color
        onblack = 40,
        onred = 41,
        ongreen = 42,
        onyellow = 43,
        onblue = 44,
        onmagenta = 45,
        oncyan = 46,
        onwhite = 47,
    }

    for c, v in pairs(colors) do
        ansicolor.color[c] = makecolor(v,colormt)
    end
    ansicolor.sys = ansicolor.color["clear"]
    ansicolor.ctext = ansicolor.color["black"]
    ansicolor.cbkg = ansicolor.color["onwhite"]
    ---@param color string
    function ansicolor:SetSys(color)
        if self.color[color] == nil then return 0 end
        self.sys = self.color[color]
    end
    ---@param color string
    function ansicolor:SetTextColor(color)
        if self.color[color] == nil then return 0 end
        self.ctext = self.color[color]
    end
    ---@param color string
    function ansicolor:SetBackgroundColor(color)
        if self.color["on"..color] == nil then return 0 end
        self.cbkg = self.color["on"..color]
    end
    ---@param sys string
    ---@param clbkg string
    ---@param cltext string
    ---@param char string 
    ---@return string
    ---get char with color code
    function ansicolor:GetChar(sys,clbkg,cltext,char)
        local str = self.color[sys]
        str = str .. self.color[clbkg]
        str = str .. self.color[cltext]
        str = str .. char .. self.color["reset"]
        return str
    end
    ---@param text string
    function ansicolor:Print(text)
        print(self.sys.. self.ctext .. self.cbkg .. text .. self.color["reset"])
    end
    return ansicolor
end





