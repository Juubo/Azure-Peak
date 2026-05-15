/mob/living/carbon/human/species/human/northern/bum/boss
	d_intent = INTENT_PARRY
	dodgetime = 10 //CC Edit - Slippery Bastard.

/mob/living/carbon/human/species/human/northern/bum/boss/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
	if(bum_boss)
		equipOutfit(new /datum/outfit/job/roguetown/vagrant_boss)
