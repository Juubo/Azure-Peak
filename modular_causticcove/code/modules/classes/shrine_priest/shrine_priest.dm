/datum/advclass/mercenary/shrine_priest
	name = "Shrine Priest"
	tutorial = "Your a priest or Priestess from the eastern lands of Kazengun. Trained in the arts of hunting unnatural or supernatural creatures that interrupt the balance of nature. Using your blade for the sake of others along with the miracles and rituals at your disposal to heal others or burn your foes in holy flame."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //no dwarf sprites
	outfit = /datum/outfit/job/roguetown/mercenary/shrine_priest
	subclass_languages = list(/datum/language/kazengunese)
	class_select_category = CLASS_CAT_KAZENGUN
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_CRITICAL_RESISTANCE)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	subclass_stats = list(
		STATKEY_INT = 2,
		STATKEY_WIL = 1,
		STATKEY_STR = 1,
		STATKEY_CON = 1
	)
	subclass_skills = list(
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/alchemy = SKILL_LEVEL_EXPERT
	)

/datum/outfit/job/roguetown/mercenary/shrine_priest
	allowed_patrons = list(/datum/patron/divine/astrata)

/datum/outfit/job/roguetown/mercenary/shrine_priest/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("Your a priest or Priestess from the eastern lands of Kazengun. Trained in the arts of hunting unnatural or supernatural creatures that interrupt the balance of nature. Using your blade for the sake of others along with the miracles and rituals at your disposal to heal others or burn your foes in holy flame."))
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_2)
	head = /obj/item/clothing/head/roguetown/mentorhat
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants2
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
	shoes = /datum/supply_pack/rogue/wardrobe/shoes/sandals
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/neck/roguetown/psicross/astrata
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern,
		/obj/item/needle,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
		/obj/item/roguekey/mercenary
		)
	H.set_blindness(0)
	beltl = /obj/item/rogueweapon/sword/sabre/mulyeog
	beltr = /obj/item/rogueweapon/scabbard/sword/kazengun
