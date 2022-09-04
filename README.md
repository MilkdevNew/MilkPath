# MilkPath

## About

I needed a pathfinding module but all did not work with what I was making so I made my own

## Installing

This is how you use it

Install from coping the code from MilkPath.lua or [Here](https://www.roblox.com/library/10768784278/MainModule)

For automatic update use 10768784278 in your script

## How to use

> :warning: _This module is server-side_

Here is code to use MilkPath

```lua
local MilkPath = require(10768784278) -- loads the module
local Character = path.to.Character

local Data = { -- You can also add agentData
    AgentRadius = 3,
	AgentHeight = 6,
	AgentCanJump = false,
	Costs = {
		Water = 20
	}
}

local Path = MilkPath.new(Character,Data)

Path:Run(game.Workspace.Part) -- You can use a part or a vector3

-- To debug when using run add a bool value
Path:Run(game.Workspace.Part,true) -- This will show how the path is made

```

## Api Comming Soon!
