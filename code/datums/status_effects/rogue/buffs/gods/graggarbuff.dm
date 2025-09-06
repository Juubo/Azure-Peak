///////////////////////////
// Graggar Related Buffs //
///////////////////////////

//Graggar boons
/datum/status_effect/buff/call_to_slaughter
	id = "call_to_slaughter"
	alert_type = /atom/movable/screen/alert/status_effect/buff/call_to_slaughter
	duration = 2.5 MINUTES
	effectedstats = list("strength" = 1, "endurance" = 2, "constitution" = 1)

/atom/movable/screen/alert/status_effect/buff/call_to_slaughter
	name = "Call to Slaughter"
	desc = span_bloody("LAMBS TO THE SLAUGHTER!")
	icon_state = "call_to_slaughter"

#define BLOODRAGE_FILTER "bloodrage"

/atom/movable/screen/alert/status_effect/buff/graggar_bloodrage
	name = "BLOODRAGE"
	desc = "GRAGGAR! GRAGGAR! GRAGGAR!"
	icon_state = "bloodrage"

/datum/status_effect/buff/bloodrage
	id = "bloodrage"
	alert_type = /atom/movable/screen/alert/status_effect/buff/graggar_bloodrage
	var/outline_color = "#ad0202"
	duration = 15 SECONDS

/datum/status_effect/buff/bloodrage/on_apply()
	ADD_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	var/holyskill = owner.get_skill_level(/datum/skill/magic/holy)
	duration = ((15 SECONDS) * holyskill)
	var/filter = owner.get_filter(BLOODRAGE_FILTER)
	if(!filter)
		owner.add_filter(BLOODRAGE_FILTER, 2, list("type" = "outline", "color" = outline_color, "alpha" = 60, "size" = 2))
	if(!HAS_TRAIT(owner, TRAIT_DODGEEXPERT))
		if(owner.STASTR < STRENGTH_SOFTCAP)
			effectedstats = list("strength" = (STRENGTH_SOFTCAP - owner.STASTR))
			. = ..()
			return TRUE
	if(holyskill >= SKILL_LEVEL_APPRENTICE)
		effectedstats = list("strength" = 2)
	else
		effectedstats = list("strength" = 1)
	. = ..()
	return TRUE

/datum/status_effect/buff/bloodrage/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	owner.visible_message(span_warning("[owner] wavers, their rage simmering down."))
	owner.OffBalance(3 SECONDS)
	owner.remove_filter(BLOODRAGE_FILTER)
	owner.emote("breathgasp", forced = TRUE)
	owner.Slowdown(3)

#undef BLOODRAGE_FILTER
