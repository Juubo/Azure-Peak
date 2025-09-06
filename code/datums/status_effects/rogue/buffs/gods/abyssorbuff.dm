///////////////////////////
// Abyssor Related Buffs //
///////////////////////////

//Abyssor boons
/atom/movable/screen/alert/status_effect/buff/abyssal
	name = "Abyssal strength"
	desc = "I feel an unnatural power dwelling in my limbs."
	icon_state = "abyssal"

#define ABYSSAL_FILTER "abyssal_glow"

/datum/status_effect/buff/abyssal
	var/dreamfiend_chance = 0
	var/stage = 1
	var/str_buff = 3
	var/con_buff = 3
	var/end_buff = 3
	var/speed_malus = 0
	var/fortune_malus = 0
	var/perception_malus = 0
	var/outline_colour ="#00051f"
	alert_type = /atom/movable/screen/alert/status_effect/buff/abyssal
	examine_text = "SUBJECTPRONOUN has muscles swollen with a strange pale strength."
	id = "abyssal_strength"
	duration = 450 SECONDS

/datum/status_effect/buff/abyssal/on_creation(mob/living/new_owner, new_str, new_con, new_end, new_fort, new_speed, new_per)
	str_buff = new_str
	con_buff = new_con
	end_buff = new_end
	fortune_malus = new_fort
	speed_malus = new_speed
	perception_malus = new_per

	effectedstats = list(
		"strength" = str_buff,
		"constitution" = con_buff,
		"endurance" = end_buff,
		"fortune" = fortune_malus,
		"speed" = speed_malus,
		"perception" = perception_malus
	)
	
	return ..()

/datum/status_effect/buff/abyssal/on_apply()
	. = ..()
	var/filter = owner.get_filter(ABYSSAL_FILTER)
	ADD_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	if (!filter)
		owner.add_filter(ABYSSAL_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 180, "size" = 1))
	to_chat(owner, span_warning("My limbs swell with otherworldly power!"))

/datum/status_effect/buff/abyssal/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	owner.remove_filter(ABYSSAL_FILTER)
	to_chat(owner, span_warning("the strange power fades"))

#undef ABYSSAL_FILTER
