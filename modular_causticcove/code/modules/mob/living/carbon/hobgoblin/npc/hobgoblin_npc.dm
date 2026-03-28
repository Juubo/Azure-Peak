/mob/living/carbon/human/species/hobgoblin/npc
	aggressive=1
	mode = NPC_AI_IDLE
	dodgetime = 20 //Bigger, Better, dodges every 2 seconds
	flee_in_pain = FALSE //GOBBY NO LIKE PAIN BUT ME BIG HOBBY WE NO HATE PAIN!!! (They're stronger.)
	npc_jump_chance = 40 //Not as nimble, less jumping...
	npc_jump_distance = 4 //But further distance by 1 tile compared to goblins.
	rude = TRUE
	wander = FALSE

	//smart_combatant = TRUE

	//Can use special attacks, but cannot parry or feint our foe.
	special_attacker = TRUE

/mob/living/carbon/human/species/hobgoblin/npc/ambush
	wander = TRUE
	//attack_speed = 1 //Unused var from npc AI? If it gets used in the future uncomment this.

//These guys will cast miracles from Graggar himself.
/mob/living/carbon/human/species/hobgoblin/npc/miracle_worker
	//No jumping. This drains stamina like CRAZY with spellcasters.
	npc_jump_chance = 0
	npc_jump_distance = 5 //Should never jump but on the off chance it does WOW they got a huge leap.
	hobgob_outfit = /datum/outfit/job/roguetown/npc/hobgoblin/miracle_worker

/mob/living/carbon/human/species/hobgoblin/npc/miracle_worker/ambush
	wander = TRUE
	
/mob/living/carbon/human/species/hobgoblin/npc/miracle_worker/Initialize()
	. = ..()
	//We're good at casting spells but not that good.
	spell_cd_offset = rand(3 SECONDS, 5 SECONDS)
	//Channel our supportive spells only for a second.
	spell_channel_duration = 1 SECONDS
