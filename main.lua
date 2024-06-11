Images = {}

Path = love.filesystem.getWorkingDirectory()
Path = string.sub(Path, 0, #Path-17) .. "PathOfTerraria/"

local assetPath = "../PathOfTerraria/Assets/Passives"

function LoadImages()
    Images = {}
    local pfile = io.popen('dir "'..assetPath..'" /b')
    for filename in pfile:lines() do
        local file = io.open(Path .. "Assets/Passives/" .. filename, "rb")
        local contents = file:read("*all")
        local data = love.filesystem.newFileData( contents, "img.png", "file" )
        local imgdata = love.image.newImageData( data )
        file:close()
        local img = love.graphics.newImage( imgdata )

        local filenameNoPng = string.sub(filename, 1, #filename-4)
        local id = filenameNoPng

        Images[id] = img
    end
    pfile:close()
end
LoadImages()

function GetImage(id)

    if Images[id] == nil then
        error("Image: [" .. id .. "] not found.")
    end

    return Images[id]
end

require "LoveKeybindings.ShortcutHandler"
local dkjson = require "LoveKeybindings.dkjson"

local Node = require "node"

SelectedNode1 = nil
SelectedNode2 = nil

Trees = {}
local nodes = {}
local edges = {}

CurTree = nil

function LoadTrees()
    Trees = {}
    nodes = {}
    edges = {}
    CurTree = nil
    for _, v in pairs({"Magic", "Melee", "Ranged", "Summoner"}) do
        local file = io.open(Path .. "Data/Passives/" .. v .. "Passives.json", "r")
        local contents = file:read("*all")
        local dataNodes = dkjson.decode(contents)
        Trees[v] = {}
        for _, nodeData in pairs(dataNodes) do
            Trees[v][nodeData.referenceId] = Node:new(nodeData)
        end
        file:close()
    end
end
LoadTrees()

function deepPrint(val, depth)
    for i, val2 in pairs(val) do
        if type(val2) == "table" then
            print(depth..i.." | entering table:")
            deepPrint(val2, depth .. "    ")
        else
            print(depth..i.." | "..val2)
        end
    end
end

--deepPrint(trees, "")

local largestId = 0

function GetNextId()
    largestId = largestId + 1
    return largestId
end

function SetTree(type)
    CurTree = type
    nodes = Trees[type]
    edges = {}

    for i, node in pairs(nodes) do
        largestId = math.max(i, largestId)
        for _, connection in pairs(node.connections) do
            table.insert(edges, {i, connection})
        end
    end
end

local offset = {400, 400}
function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("CurTree: " .. (CurTree or ""), 10, 10)

    love.graphics.translate(offset[1], offset[2])
    for _, edge in pairs(edges) do
        local x1 = nodes[edge[1]].x
        local y1 = nodes[edge[1]].y
        local x2 = nodes[edge[2]].x
        local y2 = nodes[edge[2]].y

        local r = math.atan2(y2-y1, x2-x1) + math.pi/2

        love.graphics.line(x1 + math.cos(r) * 10, y1 + math.sin(r) * 10, x2, y2)
        love.graphics.line(x1 - math.cos(r) * 10, y1 - math.sin(r) * 10, x2, y2)
    end

    if (SelectedNode1 ~= nil) then
        love.graphics.circle("line", SelectedNode1.x, SelectedNode1.y, math.max(SelectedNode1.width, SelectedNode1.height) / 2 * 1.1)
    end
    if (SelectedNode2 ~= nil) then
        love.graphics.circle("line", SelectedNode2.x, SelectedNode2.y, math.max(SelectedNode2.width, SelectedNode2.height) / 2 * 1.1)

        local r1 = math.max(SelectedNode1.width, SelectedNode1.height) / 2 * 1.1
        love.graphics.print("1", SelectedNode1.x + r1, SelectedNode1.y - r1)
        
        local r2 = math.max(SelectedNode2.width, SelectedNode2.height) / 2 * 1.1
        love.graphics.print("2", SelectedNode2.x + r2, SelectedNode2.y - r2)
    end
    
    for _, node in pairs(nodes) do
        node:draw()
    end
end

local holding = false
local moved = false
local moveTolerance = {}
function love.mousepressed(x, y, mb)
    if mb == 1 then
        holding = true
        moved = false
        moveTolerance = {}
    elseif mb == 2 then
        SelectedNode1 = nil
        SelectedNode2 = nil
    end
end

function love.mousereleased(x, y, mb)
    x = x - offset[1]
    y = y - offset[2]

    if mb == 1 then
        holding = false
        
        if moveTolerance ~= nil then
            local clicked = false
            for _, node in pairs(nodes) do
                if node:mousepressed(x, y) then
                    clicked = true
                end
            end

            if not clicked then
                SelectedNode1 = nil
                SelectedNode2 = nil
            end
        end
    end
end

function love.mousemoved(x, y, xd, yd)
    if holding then
        if moveTolerance == nil then
            offset = {offset[1] + xd, offset[2] + yd}
        else
            if #moveTolerance < 3 then
                table.insert(moveTolerance, {xd, yd})
            else
                table.insert(moveTolerance, {xd, yd})
                for _, v in pairs(moveTolerance) do
                    offset = {offset[1] + v[1], offset[2] + v[2]}
                end

                moveTolerance = nil
            end
        end
    end
end
