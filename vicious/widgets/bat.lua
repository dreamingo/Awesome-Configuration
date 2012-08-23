--test to write my first applet power


--local function worker(format,warg)
--	if not warg then return end


--Get the power state according to the apci
local tonumber = tonumber
local io = { popen = io.popen }
local setmetatable = setmetatable
local string = { match = string.match }


local bat = {}
local function worker(format, warg)
	if not warg then return end

	local charge_state = nil
	local remain_time= nil

	local fd = io.popen("acpi")
	local power_state = fd:read("*all")

	local power_static = string.match(power_state, "%d+%%")
	local power_static_2 = string.match(power_static, "%d+")


	if string.match(power_state, "Discharging")=="Discharging" then
		charge_state = "DisCharging"
		remain_time = string.match(power_state, "%d%d:%d%d:%d%d")
	elseif string.match(power_state, "Charging")=="Charging" then
		charge_state = "Charging"
		remain_time = string.match(power_state, "%d%d:%d%d:%d%d")
	elseif power_static_2 == "100" then
		charge_state = "Charged"

	else
		charge_state = "Unknown"
		remain_time = "Unknown"
	end

	--return {power_static,charge_state, remain_time}
	return {tonumber(power_static_2),charge_state}
end

return setmetatable(bat, { __call = function(_, ...) return worker(...) end })
--return setmetatable(charge_state, {__call = function(_, ...) return worker(...) end})






