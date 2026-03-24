/obj/effect/landmark/map_load_mark/variant/forest_grove_S/river_bridge
	name = "River Bridge"
	templates = list("river_bridge_default", "river_bridge_tall")
	
/datum/map_template/river_bridge
	name = "river_bridge_default"
	width = 4
	height = 11
	mappath = "modular_causticcove/_maps/map_files/templates/cove_world/forest_grove_S/variants/river_bridge/river_bridge_default.dmm"

//Taller variant. Goes up a Z-Level briefly, and goes back down. Unironically very good at preventing a good majority of hostile mobs from crossing.
//Also change of scenery! How nice!
/datum/map_template/river_bridge/tall
	name = "river_bridge_tall"
	mappath = "modular_causticcove/_maps/map_files/templates/cove_world/forest_grove_S/variants/river_bridge/river_bridge_tall.dmm"
