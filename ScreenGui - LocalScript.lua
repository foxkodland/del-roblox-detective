local gui = script.Parent

local replicatedstorage = game:GetService("ReplicatedStorage")
local statustag = replicatedstorage:WaitForChild("StatusTag")
local timertag = replicatedstorage:WaitForChild("TimerTag")
local statustitle = gui:WaitForChild("StatusTitle")

local statustitle = gui:WaitForChild("StatusTitle")

--Ссылка на RemoteEvent
local event = replicatedstorage:WaitForChild("RemoteEvent")
--Путь к основной оболочке интерфейса класса
local class = gui:WaitForChild("Class")
--Путь к тексту с названием роли игрока
local classname = class:WaitForChild("ClassName")
--Путь к тексту с описанием роли игрока
local classdescription = class:WaitForChild("ClassDescription")

--GUI окна результата матча
local result = gui:WaitForChild("Result")

--Переводим минуты в секунды
function secondstimer(seconds)
	local minutes = math.floor(seconds / 60)
	local remainingseconds = seconds % 60
	return tostring(minutes) .. ":" .. remainingseconds
end

--Изменяем текст 
function updatestatus()
	if timertag.Value < 0 then
		statustitle.Text = statustag.Value
	else
		statustitle.Text = statustag.Value .. " (" .. secondstimer(timertag.Value) ..")"
	end
end

timertag.Changed:Connect(updatestatus)
statustag.Changed:Connect(updatestatus)
updatestatus()

--событие, по которому меняется GUI с ролью
event.OnClientEvent:Connect(function(...)
	local tuple = {...}
	if tuple[1] == "Class" then
		if tuple[2] == "Murder" then
			classname.Text = "You are the Murder!"
			classdescription.Text = "Kill all Players"
		elseif tuple[2] == "Sheriff" then
			classname.Text = "You are the Sheriff"
			classdescription.Text = "Find and Kill the Murder"
		else
			classname.Text = "You are the Player"
			classdescription.Text = "Help the Sheriff find the Murder"
		end
		class.Visible = true
		wait(7)
		class.Visible = false
	elseif tuple[1] == "Result" then
		if tuple[2] == "PlayersWin" then
			result.Text = "Players WIN!!!!"
		else
			result.Text = "Murder WIN!!!!"
		end
		result.Visible = true
		wait(7)
		result.Visible = false
	end
end)
