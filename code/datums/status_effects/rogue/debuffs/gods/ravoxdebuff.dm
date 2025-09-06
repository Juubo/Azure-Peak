///////////////////////////
// Ravox Related Debuffs //
///////////////////////////

//where Ravox related debuffs go

//Ravox's call to arms
/datum/status_effect/debuff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_arms
	effectedstats = list("endurance" = -2, "constitution" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_arms
	name = "Ravox's Call to Arms"
	desc = "His voice keeps ringing in your ears, rocking your soul.."
	icon_state = "call_to_arms"

/datum/status_effect/debuff/ravox_burden
	id = "ravox_burden"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ravox_burden
	effectedstats = list("speed" = -2, "endurance" = -3)
	duration = 12 SECONDS

/atom/movable/screen/alert/status_effect/debuff/ravox_burden
	name = "Ravox's Burden"
	desc = "My arms and legs are restrained by divine chains!\n"
	icon_state = "restrained"
