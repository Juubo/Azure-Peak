/* Utility spells - non-combat support magic or very niche in combat spells meant to be freely available
to all mage classes.
*/
GLOBAL_LIST_INIT(utility_spells, (list(
		/datum/action/cooldown/spell/light,
		/datum/action/cooldown/spell/mending,
		///obj/effect/proc_holder/spell/invoked/mending/lesser, //Caustic Edit: For those who need to be cheap. -- Jon: The Mage 2 update likely wiped this from existence :<
		/datum/action/cooldown/spell/message,
		/datum/action/cooldown/spell/mindlink,
		/datum/action/cooldown/spell/find_familiar,
		/datum/action/cooldown/spell/create_campfire,
		/datum/action/cooldown/spell/projectile/lesser_fetch,
		/datum/action/cooldown/spell/projectile/lesser_repel,
		/datum/action/cooldown/spell/lesser_knock,
		/datum/action/cooldown/spell/nondetection,
		/datum/action/cooldown/spell/darkvision, // Buff but it is fine to also put it in this list
		/datum/action/cooldown/spell/magicians_brick,
		/datum/action/cooldown/spell/mirror_transform,
		/obj/effect/proc_holder/spell/targeted/touch/sizespell, //Caustic edit
		/obj/effect/proc_holder/spell/invoked/conjure_tool/mage, // Caustic Edit -- Jon: These both might need retooling as well for the new system?
		/datum/action/cooldown/spell/touch/rune_ward
		)
))

