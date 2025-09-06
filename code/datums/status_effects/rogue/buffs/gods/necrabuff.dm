///////////////////////////
// Necra Related Buffs   //
///////////////////////////

//Necra Boons
/atom/movable/screen/alert/status_effect/buff/necras_vow
	name = "Vow to Necra"
	desc = "I have pledged a promise to Necra. Undeath shall be harmed or lit aflame if they strike me. Rot will not claim me. Lost limbs can only be restored if they are myne."
	icon_state = "necravow"

#define NECRAVOW_FILTER "necravow_glow"

/datum/status_effect/buff/necras_vow
	var/outline_colour ="#929186" // A dull grey.
	id = "necravow"
	alert_type = /atom/movable/screen/alert/status_effect/buff/necras_vow
	effectedstats = list("constitution" = 2)
	duration = -1

/datum/status_effect/buff/necras_vow/on_apply()
	. = ..()
	var/filter = owner.get_filter(NECRAVOW_FILTER)
	if (!filter)
		owner.add_filter(NECRAVOW_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	ADD_TRAIT(owner, TRAIT_NECRAS_VOW, TRAIT_MIRACLE)
	owner.rot_type = null
	to_chat(owner, span_warning("My limbs feel more alive than ever... I feel whole..."))

/datum/status_effect/buff/necras_vow/on_remove()
	. = ..()
	owner.remove_filter(NECRAVOW_FILTER)
	to_chat(owner, span_warning("My body feels strange... hollow..."))

#undef NECRAVOW_FILTER
