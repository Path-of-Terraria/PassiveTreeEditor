local s = require "LoveKeybindings.Shortcut"

local MyKey = s:new()

MyKey.key = "t"

function MyKey:onActivate()
    SelectedNode1 = nil
    SelectedNode2 = nil

    LoadTree()
    GenEdges()
    
end

return MyKey