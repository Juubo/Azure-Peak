///////////////////////////
// Eora Related Debuffs  //
///////////////////////////

//where Eora related debuffs go
#define POM_FILTER "pom_aura"

/datum/status_effect/debuff/pomegranate_aura
	id = "pomegranate_aura"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/pomegranate_aura
	var/outline_colour ="#42001f"
	var/datum/weakref/source_ref

/datum/status_effect/debuff/pomegranate_aura/on_creation(mob/living/owner, tree)
	source_ref = WEAKREF(tree)
	var/str_change = 0
	var/perc_change = 0

	if(owner.patron.type != /datum/patron/divine/eora)
		str_change = -8
		perc_change = -8
	else if (!(owner.get_skill_level(/datum/skill/magic/holy) >= 1))
		//Eorans get a slight edge.
		str_change = -6
		perc_change = -6
	else
		//Devotees to Eora get a strong edge.
		str_change = -4
		perc_change = -2

	effectedstats = list(
		"strength" = str_change,
		"perception" = perc_change
	)

	return ..()

/datum/status_effect/debuff/pomegranate_aura/on_apply()
	. = ..()
	var/filter = owner.get_filter(POM_FILTER)
	if (!filter)
		owner.add_filter(POM_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 180, "size" = 1))
	to_chat(owner, span_warning("My combat prowess is sapped by the tree!"))

/datum/status_effect/debuff/pomegranate_aura/on_remove()
	. = ..()
	owner.remove_filter(POM_FILTER)
	to_chat(owner, span_warning("As I leave the influence of the tree, my strength returns."))

/datum/status_effect/debuff/pomegranate_aura/tick()
	// Check if source tree still exists
	var/obj/structure/eoran_pomegranate_tree/tree = source_ref?.resolve()
	if(QDELETED(tree) || !istype(tree))
		owner.remove_status_effect(src)
		return

	// Check distance to tree. This is a sanity check given the aura SHOULD remove already, but you can never be too safe :)
	if(get_dist(owner, tree) > tree.aura_range)
		owner.remove_status_effect(src)
		return

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		// Ugly people might get hurt
		if(HAS_TRAIT(H, TRAIT_UNSEEMLY) && prob(2))
			to_chat(H, span_warning("The tree's beauty burns your eyes!"))
			H.Dizzy(5)
			H.blur_eyes(5)
			H.adjustBruteLoss(10, 0)

		// Beautiful people might get healed
		else if(HAS_TRAIT(H, TRAIT_BEAUTIFUL) && prob(10))
			to_chat(H, span_good("The tree's beauty revitalizes you!"))
			H.apply_status_effect(/datum/status_effect/buff/healing, 1)

	// There is no beauty in death. Feed my tree.
	if(owner.stat == DEAD)
		owner.blood_volume = max(10, owner.blood_volume - 10)

/atom/movable/screen/alert/status_effect/pomegranate_aura
	name = "Eora's Blessing"
	desc = "You feel a sense of peace near this sacred tree."
	icon_state = "pom_peace"

#undef POM_FILTER

#define WILTING_FILTER "wilting_death"

/atom/movable/screen/alert/status_effect/eoran_wilting
	name = "WILTING"
	desc = "My limbs are falling off!"
	icon_state = "pom_death"

/datum/status_effect/debuff/eoran_wilting
	id = "wilting"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/eoran_wilting
	var/outline_colour ="#2c2828"
	var/datum/weakref/source_ref

/datum/status_effect/debuff/eoran_wilting/on_apply()
	if(isliving(owner))
		owner.add_filter(WILTING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 210, "size" = 2))
		to_chat(owner, span_userdanger("You feel like your limbs are starting to detach horrifically, death is imminent!"))
	return TRUE

/datum/status_effect/debuff/eoran_wilting/on_remove()
	if(isliving(owner))
		var/mob/living/L = owner
		L.remove_filter(WILTING_FILTER)
	
	dismember_owner()

/datum/status_effect/debuff/eoran_wilting/tick()
	if(isliving(owner))
		var/mob/living/L = owner
		L.flash_fullscreen("redflash3", 1)
		
		// Small damage to limbs as warning
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			for(var/obj/item/bodypart/BP in C.bodyparts)
				if(BP.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
					BP.receive_damage(1)

/datum/status_effect/debuff/eoran_wilting/proc/dismember_owner()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/C = owner
	playsound(C, 'sound/misc/eat.ogg', 100, TRUE)

	// Dismember limbs in sequence
	var/static/list/dismember_order = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD
	)

	C.visible_message(span_userdanger("[C]'s limbs wither and fall off in a gruesome display!"))

	for(var/zone in dismember_order)
		var/obj/item/bodypart/BP = C.get_bodypart(zone)
		if(BP)
			C.adjustBruteLoss(50)
			BP.dismember()
			sleep(0.5 SECONDS)

#undef WILTING_FILTER
