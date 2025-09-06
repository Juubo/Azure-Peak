//revival debuffs
/atom/movable/screen/alert/status_effect/nutrition_drain
	name = "Metabolic Acceleration"
	desc = "Your body is burning energy at an accelerated rate!"
	icon_state = "nutrition_drain"

/datum/status_effect/debuff/metabolic_acceleration
	id = "metabolic_accel"
	alert_type = /atom/movable/screen/alert/status_effect/nutrition_drain
	tick_interval = 1 MINUTES
	duration = 15 MINUTES

/datum/status_effect/debuff/metabolic_acceleration/tick()
	if(!owner || owner.stat == DEAD)
		qdel(src)
		return

	if(HAS_TRAIT(owner, TRAIT_NOHUNGER))
		// For those without hunger, drain blood instead. CONSEQUENCES FOR MY TRAIT CHOICES?!
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			H.blood_volume = max(H.blood_volume - 100, BLOOD_VOLUME_SURVIVE)
	else
		// For normal humans, drain nutrition
		owner.adjust_nutrition(-100)

/datum/status_effect/debuff/metabolic_acceleration/on_creation(mob/living/new_owner)
	effectedstats = list(
		"constitution" = -5
	)

	return ..()

/datum/status_effect/debuff/dreamfiend_curse
	id = "dreamfiend_curse"
	alert_type = /atom/movable/screen/alert/status_effect/dreamfiend_curse
	/// Type of dreamfiend to summon
	var/dreamfiend_type
	var/obj/effect/proc_holder/spell/invoked/summon_dreamfiend_curse/curse_spell

/datum/status_effect/debuff/dreamfiend_curse/on_creation(mob/living/new_owner)
	// Choose dreamfiend type from weighted list
	var/list/dreamfiend_types = list(
		/mob/living/simple_animal/hostile/rogue/dreamfiend = 50,
		/mob/living/simple_animal/hostile/rogue/dreamfiend/major = 49,
		/mob/living/simple_animal/hostile/rogue/dreamfiend/ancient = 1
	)
	dreamfiend_type = pickweight(dreamfiend_types)

	effectedstats = list(
		"strength" = 1,
		"intelligence" = -5,
		"fortune" = -5,
		"speed" = -2,
		"perception" = -5
	)

	// Add summoning spell to the victim
	if(!new_owner.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/abyssal_strength))
		curse_spell = new(new_owner)
		new_owner.mind?.AddSpell(curse_spell)
		curse_spell.dreamfiend_type = dreamfiend_type
		curse_spell.timed_cooldown = world.time + 5 MINUTES

	. = ..()

	switch(dreamfiend_type)
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend/ancient)
			linked_alert.icon_state = "dreamfiend_ancient"
			linked_alert.name = "Grand Abyssal Curse."
			linked_alert.desc = "A terrifying presence if felt fraying the edges of my mind. This is a threat I cannot face alone."
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend/major)
			linked_alert.icon_state = "dreamfiend_major"
			linked_alert.name = "Major Abyssal Curse."
			linked_alert.desc = "A great deamon is sapping my mind, a dangerous foe which I must summon to regain my faculties."
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend)
			linked_alert.icon_state = "dreamfiend"

/atom/movable/screen/alert/status_effect/dreamfiend_curse
	name = "Abyssal Curse."
	desc = "A nightmare entity has revived you, but now it is draining your vitality. Summon it to confront it."

/datum/status_effect/debuff/random_revival
	id = "random_revival_debuff"
	duration = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/random_revival

/datum/status_effect/debuff/random_revival/on_apply()
	. = ..()
	// 10% chance for special teleport effect
	if(prob(10))
		apply_teleport_effect()
	else
		// 90% chance for normal debuff
		apply_random_debuff()
		if(prob(33))
			apply_random_debuff()
		if(prob(20))
			apply_random_debuff()

	return TRUE

/datum/status_effect/debuff/random_revival/proc/apply_random_debuff()
	var/static/list/possible_debuffs = list(
		/datum/status_effect/debuff/revived,
		/datum/status_effect/debuff/dreamfiend_curse,
		/datum/status_effect/debuff/metabolic_acceleration,
		/datum/status_effect/debuff/malum_revival,
		/datum/status_effect/debuff/ravox_revival,
		/datum/status_effect/debuff/dendor_revival,
		/datum/status_effect/debuff/noc_revival,
	)
	var/debuff_type = pick(possible_debuffs)
	owner.apply_status_effect(debuff_type)

/datum/status_effect/debuff/random_revival/proc/apply_teleport_effect()
	var/area/target_area = locate(/area/rogue/indoors/town/manor) in GLOB.sortedAreas
	if(!target_area)
		apply_random_debuff() // Fallback if manor doesn't exist
		return

	// Find valid turf in manor
	var/turf/target_turf
	var/attempts = 0
	var/max_attempts = 5

	while(attempts < max_attempts && !target_turf)
		attempts++

		// Get all turfs in manor area
		var/list/area_turfs = get_area_turfs(target_area.type)
		if(!length(area_turfs))
			break

		var/list/valid_turfs = list()
		for(var/turf/T in area_turfs)
			if(T.density)
				continue
			if(istransparentturf(T))
				continue
			if(T.teleport_restricted)
				continue
			valid_turfs += T

		if(length(valid_turfs))
			target_turf = pick(valid_turfs)

	if(target_turf)
		// Unequip everything before teleporting
		owner.unequip_everything()

		// Teleport to manor
		owner.forceMove(target_turf)
		to_chat(owner, span_userdanger("You wake up in an unfamiliar place, stripped of your belongings!"))
		owner.Jitter(30)
	else
		// Fallback to random debuff if no valid turf found
		apply_random_debuff()

/atom/movable/screen/alert/status_effect/random_revival
	name = "Strange Aftereffects"
	desc = "The revival has left you with unexpected consequences..."

//Dendor, Malum, Ravox, Noc
//Fairly generic for now, I might give these more unique effects later!
/datum/status_effect/debuff/malum_revival
	id = "malum_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/malum_revival

/datum/status_effect/debuff/malum_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"endurance" = -5,
		"strength" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/malum_revival
	name = "Malum's Burden"
	desc = "Your body feels heavy and slow to recover."
	icon_state = "malum_burden"

/datum/status_effect/debuff/ravox_revival
	id = "ravox_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/ravox_revival

/datum/status_effect/debuff/ravox_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"strength" = -5,
		"speed" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/ravox_revival
	name = "Ravox's Weakness"
	desc = "Your muscles feel feeble and movements sluggish."
	icon_state = "ravox_weakness"

/datum/status_effect/debuff/dendor_revival
	id = "dendor_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/dendor_revival

/datum/status_effect/debuff/dendor_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"speed" = -5,
		"constitution" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/dendor_revival
	name = "Dendor's Sluggishness"
	desc = "Your movements are weighted by invisible roots and your body feels fragile."
	icon_state = "dendor_sluggish"

/datum/status_effect/debuff/noc_revival
	id = "noc_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/noc_revival
	tick_interval = 10 SECONDS
	var/static/list/valid_body_zones = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG
	)

/datum/status_effect/debuff/noc_revival/on_creation(mob/living/new_owner)
	effectedstats = list("intelligence" = -5)
	return ..()

/datum/status_effect/debuff/noc_revival/tick()
	// Check if outside at night
	if(istype(get_area(owner), /area/rogue/outdoors) && (GLOB.tod == "night"))
		if(prob(15))
			to_chat(owner, span_danger("Moonlight sears your flesh!"))
			owner.adjustFireLoss(15)
			if(iscarbon(owner))
				var/mob/living/carbon/C = owner
				var/list/valid_parts = list()

				for(var/obj/item/bodypart/BP in C.bodyparts)
					var/BP_name = BP.name
					if(!BP_name) BP_name = "Unnamed Bodypart" // Fallback

					var/bool_can_bloody_wound = BP.can_bloody_wound()
					var/bool_in_zone = (BP.body_zone in valid_body_zones)
					var/bool_combined_condition = (bool_in_zone && bool_can_bloody_wound)

					if(bool_combined_condition) //Idk but it works like this.
						valid_parts += BP

				if(length(valid_parts))
					var/obj/item/bodypart/BP = pick(valid_parts)
					BP.add_wound(/datum/wound/nocburn, FALSE, "looks burnt.")

/datum/wound/nocburn
	name = "light burn"
	whp = 15
	sewn_whp = 5
	bleed_rate = 0
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.1
	sewn_clotting_threshold = 0.05
	sew_threshold = 25
	mob_overlay = "cut"
	can_sew = TRUE
	//It's.. a burn..
	can_cauterize = FALSE

/atom/movable/screen/alert/status_effect/noc_revival
	name = "Noc's Moonlit Curse"
	desc = "Your mind feels clouded and moonlight burns your skin."
	icon_state = "noc_curse"
