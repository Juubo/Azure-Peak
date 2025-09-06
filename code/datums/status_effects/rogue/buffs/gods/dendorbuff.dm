///////////////////////////
// Dendor Related Buffs  //
///////////////////////////

//Dendor Boons
/atom/movable/screen/alert/status_effect/buff/lesserwolf
	name = "Blessing of the Lesser Wolf"
	desc = "I swell with the embuement of a predator..."
	icon_state = "buff"

/datum/status_effect/buff/lesserwolf
	id = "lesserwolf"
	alert_type = /atom/movable/screen/alert/status_effect/buff/lesserwolf
	duration = 30 MINUTES

/datum/status_effect/buff/lesserwolf/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel my leg muscles grow taut, my teeth sharp, I am embued with the power of a predator. Branches and brush reach out for my soul..."))
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, id)
	ADD_TRAIT(owner, TRAIT_STRONGBITE, id)

/datum/status_effect/buff/lesserwolf/on_remove()
	. = ..()
	to_chat(owner, span_warning("I feel Dendor's blessing leave my body..."))
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, id)
	REMOVE_TRAIT(owner, TRAIT_STRONGBITE, id)
