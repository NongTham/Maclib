--// Maclib Demo Loader
local MacLib
if isfile and isfile("Maclib/maclib.lua") then
	MacLib = loadstring(readfile("Maclib/maclib.lua"))()
elseif isfile and isfile("maclib.lua") then
	MacLib = loadstring(readfile("maclib.lua"))()
else
	MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Maclib/main/maclib.lua"))()
end

MacLib:Demo()

