minetest fake-player library


# Overview

Creates fake player instances for use with automation-related api's (without the player being online)

# Api

Basic usage:

```lua
-- create a fake-player instance
local def = { name = "someplayer" }
local is_dynamic = false -- true: formspec,breath,hp and pos return the previous value
local fplayer = fakeplayer.create(def, is_dynamic)

-- use it while the player is offline
local nodedef = minetest.registered_nodes["mymod:mynode"]
nodedef.after_place_node(pos, fplayer)
```

More advanced usage with preset position and look-dir:

```lua
local dir = { x=0, y=0, z=1 }
fakeplayer.create({
    name = "someplayer",
    look_dir = { x=0, y=0, z=1 },
    position = { x=100, y=0, z=0 }
})
```

**NOTE:** for all possible options consult the source-code

# License

* Code: `MIT`