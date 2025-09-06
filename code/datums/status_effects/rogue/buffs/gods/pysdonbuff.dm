///////////////////////////
//  Pysdon Related Buffs //
///////////////////////////

//Pysdon boons
/datum/status_effect/buff/psydonic_endurance
	id = "psydonic_endurance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/psydonic_endurance
	effectedstats = list("constitution" = 1,"endurance" = 1) 

/datum/status_effect/buff/psydonic_endurance/on_apply()
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_MEDIUMARMOR) && !HAS_TRAIT(owner, TRAIT_HEAVYARMOR))
		ADD_TRAIT(owner, TRAIT_HEAVYARMOR, src)

/datum/status_effect/buff/psydonic_endurance/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_HEAVYARMOR, src)

/atom/movable/screen/alert/status_effect/buff/psydonic_endurance
	name = "Psydonic Endurance"
	desc = "I am protected by blessed Psydonian plate armor."
	icon_state = "buff"
//pysdon crankbox
#define CRANKBOX_FILTER "crankboxbuff_glow"
/atom/movable/screen/alert/status_effect/buff/churnerprotection
	name = "Magick Distorted"
	desc = "The wailing box is disrupting magicks around me!"
	icon_state = "buff"

/datum/status_effect/buff/churnerprotection
	var/outline_colour = "#fad55a"
	id = "soulchurnerprotection"
	alert_type = /atom/movable/screen/alert/status_effect/buff/churnerprotection
	duration = 20 SECONDS

/datum/status_effect/buff/churnerprotection/on_apply()
	. = ..()
	var/filter = owner.get_filter(CRANKBOX_FILTER)
	if (!filter)
		owner.add_filter(CRANKBOX_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("I feel the wailing box distorting magicks around me!"))
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

/datum/status_effect/buff/churnerprotection/on_remove()
	. = ..()
	to_chat(owner, span_warning("The wailing box's protection fades..."))
	owner.remove_filter(CRANKBOX_FILTER)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

#undef CRANKBOX_FILTER
#undef MIRACLE_HEALING_FILTER

//shouldn't this be a debuff?	
/atom/movable/screen/alert/status_effect/buff/churnernegative
	name = "Magick Distorted"
	desc = "That infernal contraption is sapping my very arcyne essence!"
	icon_state = "buff"

/datum/status_effect/buff/churnernegative
	id ="soulchurnernegative"
	alert_type = /atom/movable/screen/alert/status_effect/buff/churnernegative
	duration = 23 SECONDS

/datum/status_effect/buff/churnernegative/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(owner, span_warning("I feel as if my connection to the Arcyne disappears entirely. The air feels still..."))
	owner.visible_message("[owner]'s arcyne aura seems to fade.")

/datum/status_effect/buff/churnernegative/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(owner, span_warning("I feel my connection to the arcyne surround me once more."))
	owner.visible_message("[owner]'s arcyne aura seems to return once more.")

/datum/status_effect/buff/cranking_soulchurner
	id = "crankchurner"
	alert_type = /atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	var/effect_color
	var/pulse = 0
	var/ticks_to_apply = 10
	var/undividedlines =list("THEY HAVE TRAPPED US HERE FOR ETERNITY!", "SAVE US, CHILD OF TEN! SHATTER THIS ACCURSED MUSIC BOX!", "DEATH TO THE PSYDONIAN, FREE US!")
	var/astratanlines =list("'HER LIGHT HAS LEFT ME! WHERE AM I?!'", "'SHATTER THIS CONTRAPTION, SO I MAY FEEL HER WARMTH ONE LAST TIME!'", "'I am royal.. Why did they do this to me...?'")
	var/noclines =list("'Colder than moonlight...'", "'No wisdom can reach me here...'", "'Please help me, I miss the stars...'")
	var/necralines =list("'They snatched me from her grasp, for eternal torment...'", "'Necra! Please! I am so tired! Release me!'", "'I am lost, lost in a sea of stolen ends.'")
	var/abyssorlines =list("'I cannot feel the coast's breeze...'", "'We churn tighter here than schooling fish...'", "'Free me, please, so I may return to the sea...'")
	var/ravoxlines =list("'Ravoxian kin! Tear this Otavan dog's head off! Free me from this damnable witchery!'", "'There is no justice nor glory to be found here, just endless fatigue...'", "'I begged for a death by the sword...'")
	var/pestralines =list("'I only wanted to perfect my cures...'", "'A thousand plagues upon the holder of this accursed machine! Pestra! Can you not hear me?!'", "'I can feel their suffering as they brush against me...'")
	var/eoralines =list("'Every caress feels like a thousand splintering bones...'", "'She was a heretic, but how could I hurt her?!'", "'I'm sorry! I only wanted peace! Please release me!'")
	var/dendorlines =list("'HIS MADNESS CALLS FOR ME! RRGHNN...'", "'SHATTER THIS BOX, SO WE MAY CHOKE THIS OTAVAN ON DIRT AND ROOTS!'", "'I miss His voice in the leaves... Free me, please...'")
	var/xylixlines =list("'ONE, TWO, THREE, FOUR- TWO, TWO, THREE, FOUR. --What do you mean, annoying?'", "'There are thirteen others in here, you know! What a good audience- they literally can't get out of their seats!'", "'Of course I went all-in! I thought he had an ace-high!'", "'No, the XYLIX'S FORTUNE was right- this definitely is quite bad.'")
	var/malumlines =list("'The structure of this cursed machine is malleable.. Shatter it, please...'", "'My craft could've changed the world...'", "'Free me, so I may return to my apprentice, please...'")
	var/matthioslines =list("'My final transaction... He will never receive my value... Stolen away by these monsters...'", "'Comrade, I have been shackled into this HORRIFIC CONTRAPTION, FREE ME!'", "'I feel our shackles twist with eachother's...'")
	var/zizolines =list("'ZIZO! MY MAGICKS FAIL ME! STRIKE DOWN THESE PSYDONIAN DOGS!'", "'CABALIST? There is TWISTED MAGICK HERE, BEWARE THE MUSIC! OUR VOICES ARE FORCED!'", "'DESTROY THE BOX, KILL THE WIELDER. YOUR MAGICKS WILL BE FREE.'")
	var/graggarlines =list("'ANOINTED! TEAR THIS OTAVAN'S HEAD OFF!'", "'ANOINTED! SHATTER THE BOX, AND WE WILL KILL THEM TOGETHER!'", "'GRAGGAR, GIVE ME STRENGTH TO BREAK MY BONDS!'")
	var/baothalines =list("'I miss the warmth of ozium... There is no feeling in here for me...'", "'Debauched one, rescue me from this contraption, I have such things to share with you.'", "'MY PERFECTION WAS TAKEN FROM ME BY THESE OTAVAN MONSTERS!'")
	var/psydonianlines =list("'FREE US! FREE US! WE HAVE SUFFERED ENOUGH!'", "'PLEASE, RELEASE US!", "WE MISS OUR FAMILIES!'", "'WHEN WE ESCAPE, WE ARE GOING TO CHASE YOU INTO YOUR GRAVE.'")

/datum/status_effect/buff/cranking_soulchurner/on_creation(mob/living/new_owner, stress, colour)
	effect_color = "#800000"
	return ..()

/datum/status_effect/buff/cranking_soulchurner/tick()
	var/obj/effect/temp_visual/music_rogue/M = new /obj/effect/temp_visual/music_rogue(get_turf(owner))
	M.color = "#800000"
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		if(!HAS_TRAIT(owner, TRAIT_INQUISITION))
			owner.add_stress(/datum/stressevent/soulchurnerhorror)
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if (!H.client)
				continue
			if (!H.has_stress_event(/datum/stressevent/soulchurner))
				switch(H.patron?.type)
					if(/datum/patron/old_god)
						if (!H.has_stress_event(/datum/stressevent/soulchurnerpsydon))
							H.add_stress(/datum/stressevent/soulchurnerpsydon)
							to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
							to_chat(H, (span_cultsmall(pick(psydonianlines))))
						if(HAS_TRAIT(H, TRAIT_INQUISITION))
							H.apply_status_effect(/datum/status_effect/buff/churnerprotection)
					if(/datum/patron/inhumen/matthios)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(matthioslines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/zizo)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(zizolines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/graggar)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(graggarlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/baotha)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(baothalines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/undivided)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(undividedlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/astrata)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(astratanlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/noc)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(noclines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/necra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(necralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/pestra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(pestralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/malum)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(malumlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/dendor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(dendorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/xylix)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(xylixlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/eora)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(eoralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/abyssor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(abyssorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/ravox)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(ravoxlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)

