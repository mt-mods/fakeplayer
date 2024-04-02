minetest fake-player library


# Overview

Creates fake player instances for use with automation-related api's (without the player being online)

# Api

```lua
-- create a fake-player instance
local def = { name = "someplayer" }
local is_dynamic = false -- true: formspec,breath,hp and pos return the previous value
local fplayer = fakeplayer.create(def, is_dynamic)

-- use it while the player is offline
local nodedef = minetest.registered_nodes["mymod:mynode"]
nodedef.after_place_node(pos, fplayer)
```

# License

* Code: `MIT`