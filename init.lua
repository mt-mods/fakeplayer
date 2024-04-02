local MP = minetest.get_modpath("fakeplayer")

fakeplayer = {}

dofile(MP.."/fakeplayer.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
	dofile(MP .. "/fakeplayer.spec.lua")
end