/obj/effect/landmark/map_load_mark/variant/forest_grove_S/abandoned_tavern
	name = "Abandoned Tavern / Inn"
	templates = list("abandoned_tavern_default", "abandoned_tavern_decayed", "abandoned_tavern_raised")
	
/datum/map_template/abandoned_tavern
	name = "abandoned_tavern_default"
	width = 17
	height = 13
	mappath = "modular_causticcove/_maps/map_files/templates/cove_world/forest_grove_S/variants/abandoned_tavern/abandoned_tavern_default.dmm"

/datum/map_template/abandoned_tavern/decayed
	name = "abandoned_tavern_decayed"
	mappath = "modular_causticcove/_maps/map_files/templates/cove_world/forest_grove_S/variants/abandoned_tavern/abandoned_tavern_decayed.dmm"

//It's an inn... But raised! It's raised up by 1 Z-level with a slightly winding path into it.
/datum/map_template/abandoned_tavern/raised_inn
	name = "abandoned_tavern_raised"
	mappath = "modular_causticcove/_maps/map_files/templates/cove_world/forest_grove_S/variants/abandoned_tavern/abandoned_tavern_raised.dmm"
