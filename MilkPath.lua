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
	self.debug = false
	self.Path = PathfindingService:CreatePath()

	if data ~= nil then
		self.Path = PathfindingService:CreatePath(data)
	else
		self.path = PathfindingService:CreatePath()
	end

	return setmetatable(self,Path)
end

function Path:Run(object)
	local path:Path = self.Path
	local Humanoid:Humanoid = self.Humanoid
	local debug = self.debug
	local Character = self.Character

	if Character.PrimaryPart.Anchored then
		Character.PrimaryPart.Anchored = false
	end

	Character.PrimaryPart:SetNetworkOwner(nil)

	CacheParts:ClearAllChildren()

	if typeof(object) == "Vector3" then

	else
		if typeof(object) == "Instance" then
			object = object.Position
		end
	end

	task.wait(1)

	local success, errorMessage = pcall(function()
		if typeof(object) == "Vector3" then
			path:ComputeAsync(self.Character.PrimaryPart.Position, object)
		else
			warn("No Vector")
		end

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
		warn("Path failed",path.Status)
	end
end

return Path
