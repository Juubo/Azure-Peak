
//If you update, or move the location of these map_templates, for sake of tracking for mappers and yourself alike please provide the X, Y, and Z coordinates and update them when possible.

//Rule of thumb for mapping is to ensure that you have 1 extra turf of space around your designated area so that if you want to add things on the side, borders, foliage, etc.
//	You will have the appropriate space to do so.

//When copying a new location on the map that is missing templates, or if you want to copy the default template, make sure to include the associated areas as well by hitting CTR+3, if you do
//	NOT see the areas, you will NOT copy them. They must be visible to copy them. 

//X: 131 Y:262 Z:2
/datum/map_template/world_templates
	name = "Default"
	id = "tavern_inn" //The internal ID of a template, so we don't need to use name.
	width = 17
	height = 13
	mappath = null

/datum/map_template/world_templates/New(path, rename, cache)
	. = ..()
	
	for(subtypesof())
