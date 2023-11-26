local gamepass = 169474787
local player = game.Players.LocalPlayer
local service = game:GetService("MarketplaceService")

script.Parent.MouseButton1Click:Connect(function()
	service:PromptGamePassPurchase(player, gamepass)
end)
