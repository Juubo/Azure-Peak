///////////////////////////
// Matthios Related Buffs//
///////////////////////////


//Matthios boons
 #define EQUALIZED_GLOW "equalizer glow"
/datum/status_effect/buff/equalizebuff
	id = "equalize"
	alert_type = /atom/movable/screen/alert/status_effect/buff/equalized
	effectedstats = list("strength" = 2, "constitution" = 2, "speed" = 2)
	duration = 1 MINUTES
	var/outline_colour = "#FFD700"

/atom/movable/screen/alert/status_effect/buff/equalized
	name = "Equalized"
	desc = "Equalized, with a gentle thumb on the scale, tactfully."

/datum/status_effect/buff/equalizebuff/on_apply()
	. = ..()
	owner.add_filter(EQUALIZED_GLOW, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))

/datum/status_effect/buff/equalizebuff/on_remove()
	. = ..()
	owner.remove_filter(EQUALIZED_GLOW)
	to_chat(owner, "<font color='yellow'>My link wears off, their stolen fire returns to them</font>")

#undef EQUALIZED_GLOW 
