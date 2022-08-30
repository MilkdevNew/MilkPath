local Path = {}
Path.__index = Path

local PathfindingService = game:GetService("PathfindingService")

local CacheParts = Instance.new("Folder")
CacheParts.Name = "PathfindingParts"
CacheParts.Parent = workspace

local function part(position)
	local part = Instance.new("Part")
	part.Name = "Part"
	part.Shape = Enum.PartType.Ball
	part.Position = position
	part.Size = Vector3.new(0.409, 0.409, 0.409)
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	part.Parent = CacheParts
end

function Path.new(character,data)
	local self = {}
	self.Character = character
	self.Humanoid = character:WaitForChild("Humanoid")
	self.Path = PathfindingService:CreatePath(data)
		
	return setmetatable(self,Path)
end

function Path:Run(object:Vector3,debug)
	local path:Path = self.Path
	local Humanoid:Humanoid = self.Humanoid
	
	CacheParts:ClearAllChildren()
	
	local success, errorMessage = pcall(function()
		path:ComputeAsync(self.Character.PrimaryPart.Position, object)
	end)
	
	if success and path.Status == Enum.PathStatus.Success then
		local waypoints = path:GetWaypoints()
		
		for i,item in pairs(waypoints) do
			Humanoid:MoveTo(item.Position)
			if debug ~= nil then
				if debug then
					part(item.Position)
				end
			end
			Humanoid.MoveToFinished:Wait()
		end
	else
		warn(path.Status)
		warn("Path failed")
	end
end

return Path
