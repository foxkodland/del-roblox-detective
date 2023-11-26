tool = script.Parent

local speedBoost = 1.25

local handle = tool:WaitForChild("Handle")
local event = tool:WaitForChild("RemoteEvent")

local damage = 25
local swingtime = 1
local comboDelta = .5
local combo = 0

local lastClick = tick()
local isHit = true


local slashSound = handle:WaitForChild("SlashSound")
local lungeSound = handle:WaitForChild("LungeSound")
local overheadSound = handle:WaitForChild("OverheadSound")


handle.Touched:Connect(function(hit)
	if  hit and humanoid.Health > 0 then
		local targetHumanoid = hit.Parent:FindFirstChild("Humanoid")
		if targetHumanoid and targetHumanoid.Health > 0 and not isHit then
			isHit = true			
			targetHumanoid:TakeDamage(damage * combo)	
		end
	end
end)



tool.Activated:Connect(function()
	local clickDelta = tick() - lastClick
	if clickDelta > swingtime then
		lastClick = tick()
		isHit = false
		--анимация комбо
		if clickDelta < swingtime + comboDelta then
			--модуль. Когда остаток 0, то комбо 0( то есть 3 комбо будет делится с остатком 0 на 3)
			combo = (combo + 1) % 3
		else 
			combo = 0
		end
		if player then
			if combo == 0 then
				event:FireClient(player, "RunAnimation", "SlashAnim2")
				slashSound:Play()
			elseif combo == 1 then
				event:FireClient(player, "RunAnimation", "ThrustAnim2")
				lungeSound:Play()
			elseif combo == 2 then
				event:FireClient(player, "RunAnimation", "OverheadAnim2")
				overheadSound:Play()
			end
		end
	end
end)



tool.Equipped:Connect(function()
	character = tool.Parent
	player = game.Players:GetPlayerFromCharacter(character)
	humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = humanoid.WalkSpeed * speedBoost
	end
end)



tool.Unequipped:Connect(function()
	if humanoid then
		humanoid.WalkSpeed = humanoid.WalkSpeed / speedBoost
	end
end)
