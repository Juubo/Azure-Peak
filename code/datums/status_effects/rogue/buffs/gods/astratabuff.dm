///////////////////////////
// Astrata Related Buffs //
///////////////////////////

//Astrata Boons
/atom/movable/screen/alert/status_effect/buff/astrata_gaze
	name = "Astratan's Gaze"
	desc = "She shines through me, illuminating all injustice."
	icon_state = "astrata_gaze"

/datum/status_effect/buff/astrata_gaze
	id = "astratagaze"
	alert_type = /atom/movable/screen/alert/status_effect/buff/astrata_gaze
	duration = 20 SECONDS

/datum/status_effect/buff/astrata_gaze/on_apply(assocskill)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.viewcone_override = TRUE
		H.hide_cone()
		H.update_cone_show()
	var/per_bonus = 0
	if(assocskill)
		if(assocskill > SKILL_LEVEL_NOVICE)
			per_bonus++
		duration *= assocskill
	if(GLOB.tod == "day" || GLOB.tod == "dawn")
		per_bonus++
		duration *= 2
	if(per_bonus > 0)
		effectedstats = list("perception" = per_bonus)
	to_chat(owner, span_info("She shines through me! I can perceive all clear as dae!"))
	. = ..()

/datum/status_effect/buff/astrata_gaze/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.viewcone_override = FALSE
		H.hide_cone()
		H.update_cone_show()

#define BLESSINGOFSUN_FILTER "sun_glow"
/atom/movable/screen/alert/status_effect/buff/guidinglight
	name = "Guiding Light"
	desc = "Astrata's gaze follows me, lighting the path!"
	icon_state = "stressvg"

/datum/status_effect/buff/guidinglight // Hey did u follow us from ritualcircles? Cool, okay this stuff is pretty simple yeah? Most ritual circles use some sort of status effects to get their effects ez.
	id = "guidinglight"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidinglight
	duration = 30 MINUTES // Lasts for 30 minutes, roughly an ingame day. This should be the gold standard for rituals, unless its some particularly powerul effect or one-time effect(Flylord's triage)
	status_type = STATUS_EFFECT_REFRESH
	effectedstats = list("perception" = 2) // This is for basic stat effects, I would consider these a 'little topping' and not what you should rlly aim for for rituals. Ideally we have cool flavor boons, rather than combat stims.
	examine_text = "SUBJECTPRONOUN walks with Her Light!"
	var/list/mobs_affected
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj
	var/outline_colour = "#ffffff"

/datum/status_effect/buff/guidinglight/on_apply()
	. = ..()
	if (!.)
		return
	to_chat(owner, span_notice("Light blossoms into being around me!"))
	var/filter = owner.get_filter(BLESSINGOFSUN_FILTER)
	if (!filter)
		owner.add_filter(BLESSINGOFSUN_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	mob_light_obj = owner.mob_light("#fdfbd3", 10, 10)
	return TRUE

/datum/status_effect/buff/guidinglight/on_remove()
	. = ..()
	playsound(owner, 'sound/items/firesnuff.ogg', 75, FALSE)
	to_chat(owner, span_notice("The miraculous light surrounding me has fled..."))
	owner.remove_filter(BLESSINGOFSUN_FILTER)
	QDEL_NULL(mob_light_obj)

#undef BLESSINGOFSUN_FILTER
