/*
Graphite
Prevent retarded lua or administrators from doing wack shit.
by: hollow
shouts to: 
triggered - initial help with the script
avexxed - being a cool fucking dude, giving me cool fixes
wolfie - being an absolute sick cunt, give this man a beer on my tab.
dogecore - exploits being quacking crazy, chill as fuck
capn - being a fellow hack demon
 
fucks to:
garry newman - you know what you did, fuck you.
roberto ierusalimschy - i will kick you in the ribs for making this language so fucking stupid
*/
 
// what version are we on?
local swatchberse = "Version 1.9"
 
// init gang
local Detours = {}
local graphite = Color(200,200,200,255)
local green = Color(0,230,0,255)
local red = Color(220,0,0,255)

 
// Commands that make you say "why is the server running that on my behalf?"
local AntiRetard = {
        "bind",
		"bind_mac",
		"bindtoggle",
		"impulse",
		"+forward",
		"-forward",
		"+back",
		"-back",
		"+moveleft",
		"-moveleft",
		"+moveright",
		"-moveright",
		"+left",
		"-left",
		"+right",
		"-right",
		"cl_yawspeed",
		"pp_texturize",
		"pp_texturize_scale",
		"mat_texture_limit",
		"pp_bloom",
		"pp_dof",
		"pp_bokeh",
		"pp_motionblur",
		"pp_toytown",
		"pp_stereoscopy",
		"retry",
		"connect",
		"kill",
		"+voicerecord",
		"-voicerecord",
		"startmovie",
		"record"
}
 
// Nothing like some good old standardized prints.
local function LogString(str, color) 
	MsgC(graphite, "[Graphite] ", color, str ..'\n')
end
 
// Did somebody say detours in Lua?
local function DetourFunction(originalFunction, newFunction)
    Detours[newFunction] = originalFunction
    return newFunction
end
 
// I will personally kick the creator of Lua in the ribs.
RunConsoleCommand = DetourFunction(RunConsoleCommand, function(cmd, ...)
	local block = false
	for k,v in next, AntiRetard do
		if string.find(cmd, v) then
			if (...) != nil then
				local args = tostring(...)
				block = true
				LogString("Blocked RCC! - Command: " ..cmd.. " Arguments: "..args, red)
			elseif (...) == nil then
				block = true
				LogString("Blocked RCC! - Command: " ..cmd, red)
			end
		end
	end
	if !block then
		if (...) != nil then
			local args = tostring(...)
			LogString("Logged RCC - Command: " ..cmd.. " Arguments: "..args, green)
			Detours[RunConsoleCommand](cmd, ...)
		elseif (...) == nil then
			LogString("Logged RCC - Command: " ..cmd, green)
			Detours[RunConsoleCommand](cmd)
		end
	end
end)

// AVexxed WUZ here
local old_debug_getinfo = debug.getinfo;
debug.getinfo = function(function_or_stack_level, fields)
    local data = old_debug_getinfo(function_or_stack_level, fields);

    if(function_or_stack_level == _G.RunConsoleCommand || function_or_stack_level == _G.debug.getinfo) then
        data.source = "=[C]";
        data.what = "C";
    end

    return data;
end
 
// that amazing load message using our standardized function.
LogString(swatchberse.. " has loaded.", graphite)
