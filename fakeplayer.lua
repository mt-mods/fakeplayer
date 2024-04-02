
local function delay(...)
	local args = {...}
	return (function() return unpack(args) end)
end

local function get_set_wrap(name, is_dynamic)
	return (function(self)
		return self["_" .. name]
	end), (function(self, value)
		if is_dynamic then
			self["_" .. name] = type(value) == "table"
				and table.copy(value) or value
		end
	end)
end

local fake_player_metatable = {
	is_player = delay(true),
	is_fake_player = true,

	-- dummy implementation of the rest of the player API:
	add_player_velocity = delay(),  -- deprecated
	add_velocity = delay(),
	get_acceleration = delay(), -- no-op for players
	get_animation = delay({x = 0, y = 0}, 0, 0, false),
	get_armor_groups = delay({}),
	get_attach = delay(),
	get_attribute = delay(),  -- deprecated
	get_bone_position = delay(vector.zero(), vector.zero()),
	get_children = delay({}),
	get_clouds = delay({
		ambient = { r = 0, b = 0, g = 0, a = 0 },
		color = { r = 0, b = 0, g = 0, a = 0 },
		density = 0,
		height = 120,
		thickness = 10,
		speed = vector.zero(),
	}),
	get_day_night_ratio = delay(),
	get_entity_name = delay(),
	get_formspec_prepend = delay(""),
	get_fov = delay(0, false, 0),
	get_lighting = delay({
		exposure = {
			center_weight_power = 1,
			exposure_correction = 0,
			luminance_max = -3,
			luminance_min = -3,
			speed_bright_dark = 1000,
			speed_dark_bright = 1000,
		},
		saturation = 1,
		shadows = {
			intensity = .6212,
		},
	}),
	get_local_animation = delay({x = 0, y = 0}, {x = 0, y = 0}, {x = 0, y = 0}, {x = 0, y = 0}, 30),
	get_luaentity = delay(),
	get_meta = delay({
		contains = delay(false),
		get = delay(),
		set_string = delay(),
		get_string = delay(""),
		set_int = delay(),
		get_int = delay(0),
		set_float = delay(),
		get_float = delay(0),
		get_keys = delay({}),
		to_table = delay({fields = {}}),
		from_table = delay(false),
		equals = delay(false),
	}),
	get_moon = delay({
		scale = 1,
		texture = "",
		tonemap = "",
		visible = false,
	}),
	get_physics_override = delay({
		acceleration_air = 1,
		acceleration_default = 1,
		gravity = 1,
		jump = 1,
		liquid_fluidity = 1,
		liquid_fluidity_smooth = 1,
		liquid_sink = 1,
		new_move = true,
		sneak = true,
		sneak_glitch = false,
		speed = 1,
		speed_climb = 1,
		speed_crouch = 1,
	}),
	get_player_velocity = vector.zero,  -- deprecated
	get_rotation = delay(), -- no-op for players
	get_sky = delay({ r = 0, g = 0, b = 0, a = 0 }, "regular", {}, true),
	get_sky_color = delay({
		dawn_horizon = { r = 0, g = 0, b = 0, a = 0 },
		dawn_sky = { r = 0, g = 0, b = 0, a = 0 },
		day_horizon = { r = 0, g = 0, b = 0, a = 0 },
		day_sky = { r = 0, g = 0, b = 0, a = 0 },
		fog_moon_tint = { r = 0, g = 0, b = 0, a = 0 },
		fog_sun_tint = { r = 0, g = 0, b = 0, a = 0 },
		fog_tint_type = "default",
		indoors = { r = 0, g = 0, b = 0, a = 0 },
		night_horizon = { r = 0, g = 0, b = 0, a = 0 },
		night_sky = { r = 0, g = 0, b = 0, a = 0 },
	}),
	get_stars = delay({
		count = 1000,
		day_opacity = 0,
		scale = 1,
		star_color = { r = 0, g = 0, b = 0, a = 0 },
		visible = true,
	}),
	get_sun = delay({
		scale = 1,
		sunrise = "",
		sunrise_visible = true,
		texture = "",
		tonemap = "",
		visible = true,
	}),
	get_texture_mod = delay(), -- no-op for players
	get_velocity = vector.zero,
	get_yaw = delay(), -- no-op for players
	getacceleration = delay(), -- backward compatibility
	getvelocity = vector.zero, -- backward compatibility
	getyaw = delay(), -- backward compatibility
	hud_add = delay(),
	hud_change = delay(),
	hud_get = delay(),
	hud_get_flags = delay({
		basic_debug = false,
		breathbar = false,
		chat = false,
		crosshair = false,
		healthbar = false,
		hotbar = false,
		minimap = false,
		minimap_radar = false,
		wielditem = false,
	}),
	hud_get_hotbar_image = delay(""),
	hud_get_hotbar_itemcount = delay(1),
	hud_get_hotbar_selected_image = delay(""),
	hud_remove = delay(),
	hud_set_flags = delay(),
	hud_set_hotbar_image = delay(),
	hud_set_hotbar_itemcount = delay(),
	hud_set_hotbar_selected_image = delay(),
	override_day_night_ratio = delay(),
	punch = delay(),
	remove = delay(),
	respawn = delay(),
	right_click = delay(),
	send_mapblock = delay(),
	set_acceleration = delay(),
	set_animation = delay(),
	set_animation_frame_speed = delay(),
	set_armor_groups = delay(),
	set_attach = delay(),
	set_attribute = delay(), -- deprecated
	set_bone_position = delay(),
	set_clouds = delay(),
	set_detach = delay(),
	set_formspec_prepend = delay(),
	set_fov = delay(),
	set_lighting = delay(),
	set_local_animation = delay(),
	set_look_horizontal = delay(),
	set_look_pitch = delay(),
	set_look_vertical = delay(),
	set_look_yaw = delay(),
	set_minimap_modes = delay(),
	set_moon = delay(),
	set_nametag_attributes = delay(),
	set_physics_override = delay(),
	set_rotation = delay(), -- no-op for players
	set_sky = delay(),
	set_sprite = delay(), -- no-op for players
	set_stars = delay(),
	set_sun = delay(),
	set_texture_mod = delay(), -- no-op for players
	set_velocity = delay(), -- no-op for players
	set_yaw = delay(), -- no-op for players
	setacceleration = delay(), -- backward compatibility
	setsprite = delay(), -- backward compatibility
	settexturemod = delay(), -- backward compatibility
	setvelocity = delay(), -- backward compatibility
	setyaw = delay(), -- backward compatibility
}

function fakeplayer.create(def, is_dynamic)
	local wielded_item = ItemStack("")
	if def.inventory and def.wield_list then
		wielded_item = def.inventory:get_stack(def.wield_list, def.wield_index or 1)
	end
	local p = {
		get_player_name = delay(def.name),

		_formspec = def.formspec or "",
		_hp = def.hp or 20,
		_breath = 11,
		_pos = def.position and table.copy(def.position) or vector.new(),
		_properties = def.properties or { eye_height = def.eye_height or 1.47 },
		_inventory = def.inventory,
		_wield_index = def.wield_index or 1,
		_wielded_item = wielded_item,

		-- Model and view
		_eye_offset1 = vector.new(),
		_eye_offset3 = vector.new(),
		set_eye_offset = function(self, first, third)
			self._eye_offset1 = table.copy(first)
			self._eye_offset3 = table.copy(third)
		end,
		get_eye_offset = function(self)
			return self._eye_offset1, self._eye_offset3
		end,
		get_look_dir = delay(def.look_dir or vector.new()),
		get_look_pitch = delay(def.look_pitch or 0),
		get_look_yaw = delay(def.look_yaw or 0),
		get_look_horizontal = delay(def.look_yaw or 0),
		get_look_vertical = delay(-(def.look_pitch or 0)),

		-- Controls
		get_player_control = delay({
			jump=false, right=false, left=false, LMB=false, RMB=false,
			sneak=def.sneak, aux1=false, down=false, up=false
		}),
		get_player_control_bits = delay(def.sneak and 64 or 0),

		-- Inventory and ItemStacks
		get_inventory = delay(def.inventory),
		set_wielded_item = function(self, item)
			if self._inventory and def.wield_list then
				return self._inventory:set_stack(def.wield_list,
					self._wield_index, item)
			end
			self._wielded_item = ItemStack(item)
		end,
		get_wielded_item = function(self)
			if self._inventory and def.wield_list then
				return self._inventory:get_stack(def.wield_list,
					self._wield_index)
			end
			return ItemStack(self._wielded_item)
		end,
		get_wield_list = delay(def.wield_list),
		get_nametag_attributes = delay({
			bgcolor = false,
			color = { r = 0, g = 0, b = 0, a = 0 },
			text = def.name,
		}),
	}
	-- Getter & setter functions
	p.get_inventory_formspec, p.set_inventory_formspec
		= get_set_wrap("formspec", is_dynamic)
	p.get_breath, p.set_breath = get_set_wrap("breath", is_dynamic)
	p.get_hp, p.set_hp = get_set_wrap("hp", is_dynamic)
	p.get_pos, p.set_pos = get_set_wrap("pos", is_dynamic)
	p.get_wield_index, p.set_wield_index = get_set_wrap("wield_index", true)
	p.get_properties, p.set_properties = get_set_wrap("properties", false)

	-- For players, move_to and get_pos do the same
	p.move_to = p.get_pos

	-- Backwards compatibility
	p.getpos = p.get_pos
	p.setpos = p.set_pos
	p.moveto = p.move_to
	setmetatable(p, { __index = fake_player_metatable })
	return p
end
