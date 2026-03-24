SUBSYSTEM_DEF(treesetup)
	name = "treesetup"
	//CC Edit Begin
	//Edited the init_order to respect map_templates, previously this value was [ INIT_ORDER_ATOMS-10 ]
	init_order = INIT_ORDER_MINOR_MAPPING-1
	flags = SS_NO_FIRE
	//CC Edit End

	var/list/initialize_me = list()

/datum/controller/subsystem/treesetup/Initialize(timeofday)
	InitializeTrees()
	return ..()

/datum/controller/subsystem/treesetup/proc/InitializeTrees()
	for(var/A in initialize_me)
		var/obj/structure/flora/newtree/T = A
		T.build_branches()

	for(var/A in initialize_me)
		var/obj/structure/flora/newtree/T = A
		T.build_leafs()

	initialize_me = list()
