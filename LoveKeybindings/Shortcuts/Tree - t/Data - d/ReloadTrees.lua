local s = require "LoveKeybindings.Shortcut"

local MyKey = s:new()

MyKey.key = "t"

function MyKey:onActivate()
    SelectedNode1 = nil
    SelectedNode2 = nil
    
    local treeType = CurTree

    LoadTrees()
    SetTree(treeType)
end

return MyKey