---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local io = { popen = io.popen }
local setmetatable = setmetatable
local string = { match = string.match }
-- }}}


-- Volume: provides volume levels and state of requested ALSA mixers
-- vicious.widgets.volume
local volume = {}


-- {{{ Volume widget type
local function worker(format, warg)
    if not warg then return end

    local mixer_state = {
        ["on"]  = "♫", -- "",
        ["off"] = "♩"  -- "M"
    }

    -- Get mixer control contents
    --local f = io.popen("amixer get " .. warg)
    --local mixer = f:read("*all")
    --f:close()
	local fd = io.popen("amixer sget Master")
	local mixer = fd:read("*all")
	--if string.len(status) < 1 then
	  --return
		  --end
		  fd:close()
		  local volume = string.match(mixer, "%[(%d+)%%%]")  


    -- Capture mixer control state:          [5%] ... ... [on]
    --local volu, mute = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
    if volume == nil then
       return {0, mixer_state["off"]}
    end

    -- Handle mixers without mute
    if mute == "" and volume == "0"
    -- Handle mixers that are muted
    or mute == "off" then
       mute = mixer_state["off"]
    else
       mute = mixer_state["on"]
    end

    return {tonumber(volume), mute}
end
-- }}}

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
