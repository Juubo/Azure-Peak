///////////////////////////
//  Eoran Related Buffs  //
///////////////////////////

//Eoran Boons
/datum/status_effect/buff/eora_grace
	id = "eora_grace"
	duration = 10 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/eora_grace

/atom/movable/screen/alert/status_effect/eora_grace
	name = "Eora's grace"
	desc = "You feel beautiful."

/datum/status_effect/buff/eora_grace/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)
	return TRUE

/datum/status_effect/buff/eora_grace/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		REMOVE_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)

//shouldn't this come with some other benefit or stats? otherwise its a debuff?
/atom/movable/screen/alert/status_effect/buff/pacify
	name = "Blessing of Eora"
	desc = "I feel my heart as light as feathers. All my worries have washed away."
	icon_state = "buff"

/datum/status_effect/buff/pacify
	id = "pacify"
	alert_type = /atom/movable/screen/alert/status_effect/buff/pacify
	duration = 30 MINUTES

/datum/status_effect/buff/pacify/on_apply()
	. = ..()
	to_chat(owner, span_green("Everything feels great!"))
	owner.add_stress(/datum/stressevent/pacified)
	ADD_TRAIT(owner, TRAIT_PACIFISM, id)
	playsound(owner, 'sound/misc/peacefulwake.ogg', 100, FALSE, -1)

/datum/status_effect/buff/pacify/on_remove()
	. = ..()
	to_chat(owner, span_warning("My mind is my own again, no longer awash with foggy peace!"))
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, id)

#define ASHEN_FILTER
/atom/movable/screen/alert/status_effect/buff/ashen_aril
	name = "Arillean Apotheosis"
	desc = "Divine power courses through you, enhancing all abilities."
	icon_state = "buff"

/datum/status_effect/buff/ashen_aril
	id = "ashen"
	alert_type = /atom/movable/screen/alert/status_effect/buff/ashen_aril
	duration = 6 MINUTES
	var/prevent_reapply = FALSE
	var/current_boost = 5
	var/next_wound_time = 0
	var/static/list/valid_body_zones = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG
	)

/datum/status_effect/buff/ashen_aril/on_creation(mob/living/new_owner, boost_level = 5, new_duration = 6 MINUTES)
	current_boost = boost_level
	duration = new_duration
	next_wound_time = world.time - 1

	. = ..()

	switch(current_boost)
		if(3 to 5)
			linked_alert.name = "Arillean Apotheosis"
			linked_alert.desc = "Divine power courses through you, enhancing all abilities."
			linked_alert.icon_state = "pom_god"
		if(1 to 2)
			linked_alert.name = "Waning Arillean Apotheosis"
			linked_alert.desc = "The divine power within you is fading."
			linked_alert.icon_state = "pom_god"
		if(0)
			linked_alert.name = "Arillean Peace"
			linked_alert.desc = "The calm before the storm."
			linked_alert.icon_state = "pom_anxiety"
		if(-4 to -1)
			linked_alert.name = "Ashen Scourge"
			linked_alert.desc = "Your body is turning to ash!"
			linked_alert.icon_state = "pom_regret"
		if(-5)
			linked_alert.name = "Arillean Husk"
			linked_alert.desc = "Much of your body has deteriorated into ash. It is not through Eora's mercy if you are still alive somehow."
			linked_alert.icon_state = "pom_regret"

/datum/status_effect/buff/ashen_aril/on_apply()
	// Apply stat boosts to all attributes
	effectedstats = list(
		"strength" = current_boost,
		"endurance" = current_boost,
		"constitution" = current_boost,
		"intelligence" = current_boost,
		"perception" = current_boost,
		"fortune" = current_boost,
		"speed" = current_boost
	)
	//Apply Uncapped STR as long as it's still positive.
	if(current_boost > 0)
		ADD_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)

	// Apply Beautiful trait for positive boosts
	if(current_boost == 5)
		ADD_TRAIT(owner, TRAIT_BEAUTIFUL, TRAIT_MIRACLE)
		to_chat(owner, span_notice("You feel divinely empowered and radiant!"))
	else if(current_boost == 0)
		REMOVE_TRAIT(owner, TRAIT_BEAUTIFUL, TRAIT_MIRACLE)
		to_chat(owner, span_warning("Your divine beauty fades..."))
	else if (current_boost == -5)
		ADD_TRAIT(owner, TRAIT_UNSEEMLY, TRAIT_MIRACLE)
		to_chat(owner, span_notice("Your flesh is flaky and disgusting."))

	// Set visual appearance based on boost level
	switch(current_boost)
		if(3 to 5)
			owner.add_filter(ASHEN_FILTER, 2, list("type" = "outline", "color" = "#e78e08", "alpha" = 225, "size" = 2))
		if(1 to 2)
			owner.add_filter(ASHEN_FILTER, 2, list("type" = "outline", "color" = "#c0c0c0", "alpha" = 180, "size" = 1))
		if(-4 to -1)
			owner.add_filter(ASHEN_FILTER, 2, list("type" = "outline", "color" = "#a9a9a9", "alpha" = 160, "size" = 1))
		if(-5)
			owner.add_filter(ASHEN_FILTER, 2, list("type" = "outline", "color" = "#696969", "alpha" = 140, "size" = 1))

	return ..()

/datum/status_effect/buff/ashen_aril/tick()
	// Apply wounds at negative boost levels except -5
	if(current_boost < 0 && current_boost > -5 && world.time > next_wound_time)
		next_wound_time = world.time + rand(30 SECONDS, 60 SECONDS)
		if(prob(25))
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
					BP.add_wound(/datum/wound/slash, FALSE, "looks sickly and ashen.")
					new /obj/item/ash(owner.loc)
					to_chat(owner, span_warning("Your body cracks as a new wound opens, ash spilling forth."))

/datum/status_effect/buff/ashen_aril/on_remove()
	. = ..()
	owner.remove_filter(ASHEN_FILTER)
	REMOVE_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	if(!prevent_reapply)
	// Handle effect progression
		if(current_boost > -4)
			owner.apply_status_effect(/datum/status_effect/buff/ashen_aril, current_boost - 1)
		else
			// Permanent at -5 with wilting effect
			owner.apply_status_effect(/datum/status_effect/buff/ashen_aril, -5, -1)
			owner.apply_status_effect(/datum/status_effect/debuff/eoran_wilting)

#undef ASHEN_FILTER

/datum/status_effect/buff/eoran_balm_effect
	id = "eoran_balm"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = -1
	var/healing_power = 1.5
	var/waiting_for_prompt = FALSE

/datum/status_effect/buff/eoran_balm_effect/on_apply()
	to_chat(owner, span_notice("A strange balm courses through my veins, an unnatural warmth spreads through my lifeless body..."))
	. = ..()

/datum/status_effect/buff/eoran_balm_effect/tick()
	. = ..()
	var/mob/living/carbon/M = owner
	new /obj/effect/temp_visual/heal(get_turf(owner), "#cd2be2")

	if(M.stat != DEAD)
		M.remove_status_effect(src)
		return

	if(waiting_for_prompt)
		return

	M.adjustBruteLoss(-healing_power)
	M.adjustFireLoss(-healing_power)
	M.adjustToxLoss(-healing_power)
	M.adjustOxyLoss(-healing_power)
	M.adjustCloneLoss(-healing_power)

	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume + healing_power * 2, BLOOD_VOLUME_NORMAL)

	var/list/wounds = M.get_wounds()
	if(length(wounds))
		M.heal_wounds(healing_power)
		M.update_damage_overlays()

	if(M.getBruteLoss() < 50 && M.getFireLoss() < 50 && M.getToxLoss() < 50 && M.getOxyLoss() < 50 && M.blood_volume >= BLOOD_VOLUME_SAFE)

		new /obj/effect/temp_visual/heal(get_turf(M), "#8A2BE2")

		if (M.mind)
			waiting_for_prompt = TRUE
			if(alert(M, "Are you ready to face the world, once more?", "Revival", "I must go on", "Let me rest") != "I must go on")
				M.visible_message(span_warning("[M]'s body shudders but falls still again."))
				M.remove_status_effect(src)
				return

		M.adjustOxyLoss(-M.getOxyLoss()) // Full oxygen healing
		if(!M.revive(full_heal = FALSE))
			M.visible_message(span_warning("[M]'s body shudders but fails to revive!"))
			M.remove_status_effect(src)
			return

		M.emote("breathgasp")
		M.Jitter(100)
		GLOB.azure_round_stats[STATS_LUX_REVIVALS]++
		M.update_body()
		M.visible_message(span_notice("[M] is dragged back from Necra's hold!"), span_green("I awake from the void."))

		M.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)
		M.apply_status_effect(/datum/status_effect/debuff/revived)
		M.remove_status_effect(src)
