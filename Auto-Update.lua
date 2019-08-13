/*
Graphite
Prevent 'malicious' lua from kicking your lights out.
by: hollow (seventhdimensionaldreamer.net)

Automatically updates (and runs) via p̶a̶s̶t̶e̶b̶i̶n̶ github.
This isn't an attempt to hide the code, it's so you run the most up-to-date and feature filled version.
*/


http.Fetch("https://raw.githubusercontent.com/thehollowedone/Graphite/master/Graphite.lua", function(ret) RunString(ret, "Graphite") end)
