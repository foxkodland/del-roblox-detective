local tool = script.Parent

local event = tool:WaitForChild("RemoteEvent")

event.OnClientEvent:Connect(function(...)
	local parametr = {...}
	if parametr[1] == "RunAnimation" then
		local anim = tool:FindFirstChild(parametr[2])
		if anim and humanoid then
			local loadedAnim = humanoid:LoadAnimation(anim)
			if loadedAnim then
				loadedAnim:Play()				
			end			
		end
	end
end)

tool.Equipped:Connect(function()
	humanoid = tool.Parent:FindFirstChild("Humanoid")
end)


