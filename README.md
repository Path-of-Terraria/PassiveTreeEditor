![billede](https://github.com/Path-of-Terraria/PassiveTreeEditor/assets/65250596/77cdb6bb-3c18-402f-8c3d-d6b5573414a2)# PassiveTreeEditor
For path of terraria passiv skill tree (maby skill tree in the future as well?)

## How to run
To run this program, you will need [LÖVE]([https://pages.github.com/](https://love2d.org/))

Either download and run the ([LÖVE installer](https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.exe) or the [protable version](https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.zip).

Then make sure the path to the love.exe / lovec.exe is within the [Path](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/).

Now you can run LÖVE by typing `love` or `lovec` within the Command Prompt.

Make sure that the folder/repository `PassiveTreeEditor` is besides `PathOfTerraria`, now open the `PathOfTerraria` folder and run `cmd` in the navigation bar/panel where the current path is located is:
![billede](https://github.com/Path-of-Terraria/PassiveTreeEditor/assets/65250596/1b70b2eb-70c6-4af1-a556-e172eaae0b04)

This will open Command Prompt from this path, now you just need to run `love .` or `lovec .` depending on whether you want to have access to an output or not (fx, for `print`); the program uses `io.popen` which opens a temporary terminal for running commands, it will not open this termianl if run with `lovec .` as it already has the one the command was executed in.

## How to use
The program operates using "shortcuts".

Shortcuts only works when made into a ShortShortcut or pressed using the navigation menu:
![billede](https://github.com/Path-of-Terraria/PassiveTreeEditor/assets/65250596/96cec543-203a-4739-b943-d6b49149a58a)

The navigation menu can be opend by pressing `left-shift + space`, `left-control + space` opens the last "folder" you were in.

The only things relevant to creating skill trees will be found within the `Tree` folder, you open it by pressing `t`:
![billede](https://github.com/Path-of-Terraria/PassiveTreeEditor/assets/65250596/1ab00f3c-b546-4e62-a577-c6d8458e46a0)

To begin editing a tree, press `t` again to run the "SwitchTree" shortcut, then select a tree by writing its name (when you press enter, it selects the first thing in the list):

![billede](https://github.com/Path-of-Terraria/PassiveTreeEditor/assets/65250596/0992b0ed-a2b1-428b-855b-49c6ccdf93ed)

So if we just press enter, we open the magic tree.

In the tree, you can select by clicking nodes, and multi-select by shift-clicking another node (max 2).

When two nodes are selected, you can use the current ShortShortcuts to Separate(s) and Connect(c) two nodes, with two selected you can also Add(a) to place a node in btween the two selected.
If you run Add(a) whitout any nodes selected you get to specify a position (x y) and if you have one selected you can place it using the selected node as a base with either rotation (degree distance) or position (x, y).

At this point you should be able to figure the rest out on your own**.**

## Cheat sheet 
Format for cheat sheet:
### \[Name\] \[Keys to press after left-shift + space\] | \[ShortShortcut\]
\[Description\]

### Add t-a | a
Adds a new skill node, the behaviour changes depending on the amount of skill nodes selected:
0: places at a given position (x y)
1: places offset from the skill node selected either rotation (degree distance) or position (x, y)
2: places in between the two selected nodes

### Connect t-c | c
Connects two selected nodes

### SetMaxLevel t-m | #
Sets the max level of the selected node

### Offset t-o | o
Moves the selected node by (x y)

### Remove t-r | r
Removes the selected node from the tree

### Separate t-s | s
Separates two selected notes (remves any edges between them)

### SwitchTree t-t | #
Sets the current tree to one of the 4 types

### ReloadAssets t-d-a | #
Reloads all image files; we have decided that the names wont change, but if you add any this works.

### SaveThis t-d-s | #
Overrides the file containing the tree you are currently on, replacing it with the tree you are currently working on.

### ReloadTrees t-d-t | #
Reloads all passive trees, if you for some reason want to change anything manually.
