///////////////////////////
// Gods Related Debuffs  //
///////////////////////////

//This is where all the generic god debuffs go, the rest should be assigned to their basic gods or revivals

//apostasy 
/datum/status_effect/debuff/apostasy
	id = "Apostasy!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/apostasy
	effectedstats = list("fortune" = -5, "intelligence" = -3, "perception" = -2 , "speed" = -2, "endurance" = -2, "constitution" = -2)
	duration = -1
	var/resistant = FALSE
	var/original_devotion = 0
	var/original_prayer_effectiveness = 0
	var/original_passive_devotion_gain = 0
	var/original_passive_progression_gain = 0

/datum/status_effect/debuff/apostasy/on_creation(mob/living/new_owner, resistant = FALSE)
	src.resistant = resistant
	return ..()

/datum/status_effect/debuff/apostasy/on_apply()
	. = ..()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/H = owner
	if(!H.devotion)
		return FALSE

	var/datum/devotion/D = H.devotion
	original_devotion = D.devotion
	original_prayer_effectiveness = D.prayer_effectiveness
	original_passive_devotion_gain = D.passive_devotion_gain
	original_passive_progression_gain = D.passive_progression_gain

	if(resistant)
		D.devotion = original_devotion * 0.5
		D.prayer_effectiveness = original_prayer_effectiveness * 0.5
		D.passive_devotion_gain = original_passive_devotion_gain * 0.5
		D.passive_progression_gain = original_passive_progression_gain * 0.5
	else
		D.devotion = 0
		D.prayer_effectiveness = 0
		D.passive_devotion_gain = 0
		D.passive_progression_gain = 0

	to_chat(H, span_boldnotice("I have been excommunicated. I am now unable to gain devotion."))
	return ..()

/datum/status_effect/debuff/apostasy/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.devotion)
			var/datum/devotion/D = H.devotion
			D.devotion = original_devotion
			D.prayer_effectiveness = original_prayer_effectiveness
			D.passive_devotion_gain = original_passive_devotion_gain
			D.passive_progression_gain = original_passive_progression_gain

		to_chat(H, span_boldnotice("I have been welcomed back to the Church. I am now able to gain devotion again."))

/atom/movable/screen/alert/status_effect/debuff/apostasy
	name = "Apostasy!"
	desc = "Shame upon the member of clergy!"
	icon_state = "debuff"
	color ="#7a0606"

/datum/status_effect/debuff/excomm
	id = "Excommunicated!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/excomm
	effectedstats = list("fortune" = -2, "intelligence" = -2, "speed" = -1, "endurance" = -1, "constitution" = -1)
	duration = -1

/atom/movable/screen/alert/status_effect/debuff/excomm
	name = "Excommunicated!"
	desc = "The Ten have forsaken me!"
	icon_state = "muscles"
	color ="#6d1313"

/datum/status_effect/debuff/hereticsermon
	id = "Heretic on sermon!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hereticsermon
	effectedstats = list("intelligence" = -2, "speed" = -2, "fortune" = -2)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/debuff/hereticsermon
	name = "Heretic on sermon!"
	desc = "I was on the sermon. My patron is not proud of me."
	icon_state = "debuff"
	color ="#af9f9f"

/datum/status_effect/debuff/ritesexpended
	id = "ritesexpended"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritesexpended
	name = "Rites Complete"
	desc = "It will take time before I can next perform a rite."
	icon_state = "ritesexpended"

/datum/status_effect/debuff/ritesexpended_heavy
	id = "ritesexpended_heavy"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	duration = 1 HOURS

/atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	name = "Rites Complete"
	desc = "It will take a lot of time before I can perform a next rite. I am drained."
	icon_state = "ritesexpended"







