/*
Graphite
Prevent retarded lua or administrators from doing wack shit.
by: hollow
*/
 
// what version are we on? (inside joke variable name)
local swatchberse = "Version 1.9"
 
// initializes all the variables we need at the start
local Detours = {}
local graphite = Color(200,200,200,255)
local green = Color(0,230,0,255)
local red = Color(220,0,0,255)

 
// The commands we wanna block from ever making it to our console.
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
 
// Graphite uses this to print all of it's logs to console.
local function LogString(str, color) 
	MsgC(graphite, "[Graphite] ", color, str ..'\n')
end
 
// Graphite's Detour System
local function DetourFunction(originalFunction, newFunction)
    Detours[newFunction] = originalFunction
    return newFunction
end
 
// What started my hatred of Lua was making this entire project.
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

// Semi-patch of a detour detection method.
local old_debug_getinfo = debug.getinfo;
debug.getinfo = function(function_or_stack_level, fields)
    local data = old_debug_getinfo(function_or_stack_level, fields);

    if(function_or_stack_level == _G.RunConsoleCommand || function_or_stack_level == _G.debug.getinfo) then
        data.source = "=[C]";
        data.what = "C";
    end

    return data;
end
 
// We loaded, that's crazy.
LogString(swatchberse.. " has loaded.", graphite)
