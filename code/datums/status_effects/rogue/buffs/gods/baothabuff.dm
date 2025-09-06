///////////////////////////
// Baotha Related Buffs  //
///////////////////////////

//Baotha boons
/datum/status_effect/buff/griefflower
	id = "griefflower"
	alert_type = /atom/movable/screen/alert/status_effect/buff/griefflower
	effectedstats = list("constitution" = 1,"endurance" = 1) 

/datum/status_effect/buff/griefflower/on_apply()
	. = ..()
	to_chat(owner, span_notice("The Rosa’s ring draws blood, but it’s the memories that truly wound. Failure after failure surging through you like thorns blooming inward."))
	ADD_TRAIT(owner, TRAIT_CRACKHEAD, src)

/datum/status_effect/buff/griefflower/on_remove()
	. = ..()
	to_chat(owner, span_notice("You part from the Rosa’s touch. The ache retreats..."))
	REMOVE_TRAIT(owner, TRAIT_CRACKHEAD, src)

/atom/movable/screen/alert/status_effect/buff/griefflower
	name = "Rosa Ring"
	desc = "The Rosa's ring draws blood, but it's the memories that truly wound. Failure after failure surging through you like thorns blooming inward."
	icon_state = "buff"
