//--------------- BLACKSTEEL ---------------------

/obj/item/clothing/suit/roguetown/armor/plate/full/blacksteel/modern
	name = "blacksteel plate armor"
	desc = "A magnificent set of blacksteel plate armor; the greatest triumph of sixteenth-century metallurgy, forged from the rarest of manmade alloys. It befits only the presence of Psydonia's most renowned - be they a hero, a lord, or a monster."
	icon_state = "bplate"
	item_state = "bplate"

/obj/item/clothing/suit/roguetown/armor/plate/full/blacksteel
	name = "ancient blacksteel plate armor"
	desc = "An antiquated set of blacksteel plate armor, from before Psydonia's blacksmiths had fully mastered the art of tempering such a coveted alloy. If you knew that todae was to be your last, would you've done anything different? Would you've communed with your friends and family, instead of loitering in a line and bickering about the specifics of steel-and-gold? </br>	</br>Cherish lyfe as it happens, or you will forever regret the memories you can no longer recall."
	icon_state = "bkarmor"
	item_state = "bkarmor"
	blocking_behavior = null
	equip_delay_self = 6 SECONDS
	unequip_delay_self = 6 SECONDS
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	chunkcolor = "#303036"
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 3

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/modern
	name = "blacksteel half-plate"
	desc = "A masterfully tempered blacksteel cuirass; a refined triumph of Psydonia's later metallurgists. Sloped pauldrons grant its bearer both dignity and dread presence upon the field."
	icon_state = "bhalfplate"
	item_state = "bhalfplate"

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel
	name = "ancient blacksteel half-plate"
	desc = "An antiquated blacksteel cuirass, forged in an age when Psydonia's smiths still wrestled with the temperament of this jealous alloy. Its weight settles heavy upon the shoulders, and its pauldrons slope like a knight bowing to fate."
	body_parts_covered = COVERAGE_ALL_BUT_HANDLEGS
	icon_state = "bkhalfarmor"
	item_state = "bkhalfarmor"
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	chunkcolor = "#303036"

/obj/item/clothing/suit/roguetown/armor/plate/cuirass/blacksteel
	name = "blacksteel cuirass"
	desc = "A padded blacksteel cuirass; sleek, elegant, and mysterious."
	icon_state = "bcuirass"
	item_state = "bcuirass"
	armor = ARMOR_PLATE_BSTEEL
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 2
	chunkcolor = "#303036"

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer
	name = "modern artificed half-plate"
	desc = "Old knowledge rebranded, Blacksteel replacing the mistakes of the past. Light and a merging of metal-and-magicka. It holds a slot for an infernal orb to power it."
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 1
	icon_state = "artificerplate"
	item_state = "artificerplate"
	armor_class = ARMOR_CLASS_LIGHT // Artificer made blacksteel.
	max_integrity = ARMOR_INT_CHEST_LIGHT_ELITE
	var/powered = FALSE
	var/mode = 1
	var/active_item = FALSE //Prevents issues like dragon ring giving negative str instead
	var/legendaryarcane = FALSE
	var/legendaryathletics = FALSE

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/Initialize(mapload)
	.=..()
	update_description()

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/contraption/linker))
		if(user.get_skill_level(/datum/skill/craft/engineering) >= 3)
			toggle_mode(user)
			return
	if(istype(I, /obj/item/magic/infernal/core) && !powered)
		user.visible_message(span_notice("[user] starts carefully setting [I] into place as a power source."))
		if(do_after(user, 5 SECONDS, target = src))
			qdel(I)
			powered = TRUE
			icon_state ="artificerplate_powered"
			item_state = "artificerplate_powered"
	.=..()

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/proc/toggle_mode(mob/user)
	if(!src.ontable())
		to_chat(user, span_notice("I need to put this on a table first!")) //prevents stats staying on a person if tinkered on self
	else
		mode = (mode == 1) ? 2 : 1
		user.visible_message(span_notice("[user] tinkers with [src], adjusting its enhancements."))
		update_description()

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/equipped(mob/living/user, slot)
	. = ..()
	if(!powered || active_item || slot != SLOT_ARMOR)
		return
	if(mode == 1) // Arcane mode
		var/current_arcane = user.get_skill_level(/datum/skill/magic/arcane)
		if(current_arcane)
			if(current_arcane < 6) // Only add if not already capped
				active_item = TRUE
				legendaryarcane = FALSE
				user.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				user.apply_status_effect(/datum/status_effect/buff/artificerint)
				to_chat(user, span_notice("Arcyne lightning crackles across the cuirass, enchanting your mind with forbidden knowledge!"))
				icon_state ="artificerplate_powered"
				item_state = "artificerplate_powered"
			else
				user.apply_status_effect(/datum/status_effect/buff/artificerint)
				legendaryarcane = TRUE
				active_item = TRUE
				to_chat(user, span_warning("Arcyne lightning crackles across the cuirass, enshrining your mastery over magicka!"))
				icon_state ="artificerplate_powered"
				item_state = "artificerplate_powered"
		else
			to_chat(user, span_warning("The cuirass feels unnervingly cold to the touch."))
	if(mode == 2)
		if(slot != SLOT_ARMOR)
			return
		var/current_athletics = user.get_skill_level(/datum/skill/misc/athletics)
		if(current_athletics)
			if(current_athletics < 6)// Only add if not already capped
				user.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
				legendaryathletics = FALSE
				icon_state ="artificerplate_powered"
				item_state = "artificerplate_powered"
			else
				legendaryathletics = TRUE
			active_item = TRUE
			to_chat(user, span_notice("Arcyne lightning crackles across the cuirass, enchanting your body with adrenalized power!"))
			user.apply_status_effect(/datum/status_effect/buff/artificerstr)
			icon_state ="artificerplate_powered"
			item_state = "artificerplate_powered"
			return
		else
			to_chat(user, span_warning("The cuirass feels unnervingly warm to the touch."))

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/dropped(mob/living/user)
	.=..()
	if(active_item)
		if(mode == 1)
			if(user.get_skill_level(/datum/skill/magic/arcane))
				var/mob/living/carbon/human/H = user
				if(!legendaryarcane)
					H.adjust_skillrank(/datum/skill/magic/arcane, -1, TRUE)
				if(H.get_item_by_slot(SLOT_ARMOR) == src)
					to_chat(H, span_notice("Gone is the intelligence, which bolstered thine arcyna.."))
					user.remove_status_effect(/datum/status_effect/buff/artificerint)
					active_item = FALSE
					return
			else
				return
		if(mode == 2)
			if(user.get_skill_level(/datum/skill/misc/athletics))
				var/mob/living/carbon/human/H = user
				if(!legendaryathletics)
					H.adjust_skillrank(/datum/skill/misc/athletics, -1, TRUE)
				if(H.get_item_by_slot(SLOT_ARMOR) == src)
					to_chat(H, span_notice("Gone is the strength, which bolstered thine arms.."))
					user.remove_status_effect(/datum/status_effect/buff/artificerstr)
					active_item = FALSE
					return
			else
				return

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel/artificer/proc/update_description()
	if(mode == 1)
		desc = "Old knowledge rebranded, Blacksteel replacing the mistakes of the past. Light and a merging of metal-and-magicka. It crackles with raw magicka; the mind, empowered."
	else
		desc = "Old knowledge rebranded, Blacksteel replacing the mistakes of the past. Light and a merging of metal-and-magicka. It crackles with arcyne vigor; the body, emboldened."
