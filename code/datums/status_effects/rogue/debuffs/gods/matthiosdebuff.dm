///////////////////////////
//Matthios Related Debuffs//
///////////////////////////

//where Matthios related debuffs go
 #define EQUALIZED_GLOW "equalizer glow"
/datum/status_effect/debuff/equalizedebuff
	id = "equalize"
	alert_type = /atom/movable/screen/alert/status_effect/buff/equalized
	effectedstats = list("strength" = -2, "constitution" = -2, "speed" = -2)
	duration = 1 MINUTES
	var/outline_colour = "#FFD700"

/atom/movable/screen/alert/status_effect/debuff/equalized
	name = "Equalized"
	desc = "My fire is stolen from me!"

/datum/status_effect/debuff/equalizedebuff/on_apply()
	. = ..()
	owner.add_filter(EQUALIZED_GLOW, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))

/datum/status_effect/debuff/equalizedebuff/on_remove()
	. = ..()
	owner.remove_filter(EQUALIZED_GLOW)
	to_chat(owner, "<font color='yellow'>My fire returns to me!</font>")

//T3 COUNT WEALTH, HURT TARGET/APPLY EFFECTS BASED ON AMOUNT OF WEALTH. AT 500+, OLD STYLE CHURNS THE TARGET.
 #undef EQUALIZED_GLOW
